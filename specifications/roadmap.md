# Roadmap

## Now: 
  - Phase1: stage0_mongodb_api and stage0_template_mongodb_api
    - Unit Testing:
      - [ ] Test version_manager
      - [ ] Test index_manager
      - [ ] Test schema_manager
      - [ ] Test collection_service
      - [ ] Test collection_routes
      - [ ] Test server.py
    - Update py_utils
      - [ ] add upsert
      - [ ] add list/create/drop index
      - [ ] add drop/add schema
      - [ ] add ?migrate/pipeline?
    - [ ] Add batch processing support to server.py
    - Test locally
      - [ ] Batch testing
      - [ ] Curl testing
      - [ ] stepci testing
      - [ ] Container testing
    - [ ] Create github package for container image
    - [ ] Configure and Test CI, publish container
    - [ ] Create mongodb_api Template Repo
      - [ ] Create a github template repo for downstream users of the API. 
      - [ ] Create Sample Config user/organization
      - [ ] Dockerfile that is *from* stage0_mongodb_api and adds the repo's configurations
      - [ ] Create stage0_template_mongodb_api as a stage0_runbook_merge template
      - [ ] Test runbook by creating mentorHub_mongodb_api
      - [ ] Update api README.md as needed with instructions on how to use the template repo.
    
Next:
  - Phase2: stage0_mongodb_spa
    - [ ] Create Vue.js 3 SPA with TypeScript and Vuetify 3
    - [ ] Implement key features for extraction to stage0-vue-utils:
      - Configuration browser 
      - Schema viewer 
      - Execution selector
      - Progress tracking with toast notifications
      - Error handling and reporting
    - [ ] Build and Test container

  - Phase3: keycloak IAM integration with api and spa
  - Phase4: mentorhub_py_utils refactor
  - Phase5: keycloak + mentorHub_mongodb_api + stage0_mongodb_spa
  - Phase6: mentorHub_search_api
  - Phase7: mentorHub_search_spa
  - Phase8: mentorHub_admin_api
  - Phase9: mentorHub_admin_spa
  - Phase10: Extract and publish mentorHub_vue_utils
  - Phase11: Extract and publish stage0_template's 
    - stage0_template_mongodb_api
    - stage0_template_flask_search_api
    - stage0_template_vue_search_spa
    - stage0_template_flask_mongo_api
    - stage0_template_vue_spa
  - Phase12: Generate and verify all mentorHub prototypes from mentorHub/specifications
    steps:
    - Document workshops and finalize specifications
    - Generate and verify all mentorHub prototypes from mentorHub/specifications
Later:
  - Phase13: Create mentorHub Terraform configurations
  - Phase14: Create mentorHub Helm charts
  - Phase15: Create mentorHub ArgoCD configurations
  - Phase16: MentorHub on AWS - DEV and TEST and PROD environments
  - Phase17: Stage0 harvest runbooks and documentation for Paul
  - Phase18: Stage0 harvest stage0_echo_mongo_api template
  - Phase19: Complete stage0 specifications (workshops)
  - Phase20: Generate and launch stage0 prototypes to AWS
  - Phase21: Stage0 Cat
  - Phase22: Stage0 Fran
  - Phase23: Stage0 Paul
  - Phase24: Stage0 Sam
  - Phase25: Stage0 Launch