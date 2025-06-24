#!/bin/bash

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${GREEN}[+]${NC} $1"; }
print_error() { echo -e "${RED}[!]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_info() { echo -e "${BLUE}[i]${NC} $1"; }

# Configuration
GITHUB_ORG="agile-learning-institute"
REGISTRY="ghcr.io"
FULL_REGISTRY="${REGISTRY}/${GITHUB_ORG}"

# Container images to create
CONTAINER_IMAGES=(
    "stage0_kafka_connect"
    "stage0_mongo_api"
    "stage0_mongodb_spa"
    "stage0_search_api"
    "stage0_search_spa"
    "stage0_cat_bot"
    "stage0_cat_spa"
    "stage0_fran_bot"
    "stage0_fran_spa"
    "stage0_paul_bot"
    "stage0_paul_spa"
    "stage0_sam_bot"
    "stage0_sam_spa"
    "stage0_identity_api"
    "stage0_identity_spa"
)

check_docker() {
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker is not running"
        exit 1
    fi
}

check_github_auth() {
    if ! docker pull "${FULL_REGISTRY}/test:latest" 2>/dev/null; then
        print_error "Not authenticated to GitHub Container Registry"
        print_info "Run: docker login ${REGISTRY} -u USERNAME -p TOKEN"
        exit 1
    fi
}

create_container_image() {
    local image_name="$1"
    local full_image_name="${FULL_REGISTRY}/${image_name}"
    
    print_status "Creating ${image_name}"
    
    if ! docker pull hello-world:latest; then
        print_error "Failed to pull hello-world image"
        return 1
    fi
    
    if ! docker tag hello-world:latest "${full_image_name}:latest"; then
        print_error "Failed to tag image"
        return 1
    fi
    
    if ! docker push "${full_image_name}:latest"; then
        print_error "Failed to push ${full_image_name}:latest"
        return 1
    fi
    
    print_status "Successfully created ${image_name}"
    return 0
}

verify_images() {
    print_status "Verifying images..."
    
    local failed_images=()
    
    for image in "${CONTAINER_IMAGES[@]}"; do
        local full_image_name="${FULL_REGISTRY}/${image}"
        
        if docker pull "${full_image_name}:latest" >/dev/null 2>&1; then
            print_status "✓ ${image}"
        else
            print_error "✗ ${image}"
            failed_images+=("${image}")
        fi
    done
    
    if [[ ${#failed_images[@]} -eq 0 ]]; then
        print_status "All images created successfully!"
        return 0
    else
        print_error "Failed images: ${failed_images[*]}"
        return 1
    fi
}

show_usage() {
    cat <<END
Usage: $0 [OPTIONS]

Options:
    --help, -h          Show this help
    --verify-only       Only verify existing images
    --create-only       Only create images
    --list-images       List images to be created

Examples:
    $0                    # Create all images and verify
    $0 --verify-only      # Only check if images exist
    $0 --list-images      # Show list of images
END
}

list_images() {
    print_info "Container images to be created:"
    for image in "${CONTAINER_IMAGES[@]}"; do
        echo "  - ${FULL_REGISTRY}/${image}:latest"
    done
    echo "Total: ${#CONTAINER_IMAGES[@]} images"
}

main() {
    local verify_only=false
    local create_only=false
    local list_images_only=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help|-h)
                show_usage
                exit 0
                ;;
            --verify-only)
                verify_only=true
                shift
                ;;
            --create-only)
                create_only=true
                shift
                ;;
            --list-images)
                list_images_only=true
                shift
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    if [[ "$list_images_only" == true ]]; then
        list_images
        exit 0
    fi
    
    print_status "Stage0 Container Provisioning"
    print_info "Registry: ${FULL_REGISTRY}"
    print_info "Images: ${#CONTAINER_IMAGES[@]}"
    echo
    
    check_docker
    
    # if [[ "$verify_only" != true ]]; then
    #     check_github_auth
    # fi
    
    if [[ "$verify_only" != true ]]; then
        print_status "Creating container images..."
        echo
        
        local failed_count=0
        
        for image in "${CONTAINER_IMAGES[@]}"; do
            if ! create_container_image "$image"; then
                ((failed_count++))
            fi
            echo
        done
        
        if [[ $failed_count -gt 0 ]]; then
            print_error "Failed to create $failed_count images"
            exit 1
        fi
    fi
    
    if [[ "$create_only" != true ]]; then
        verify_images
    fi
    
    print_status "Container provisioning completed!"
}

main "$@" 