# LLM Prompts

# AI Assistant Workflow Guidelines
- Please follow these guidelines for our collaboration:

## ⚠️ ALWAYS Ask for Approval Before:
- Data Deletion: Any rm, drop, delete, cleanup operations
- System Changes: Docker commands, service starts/stops, environment modifications
- File System Operations: Moving/renaming/deleting files outside current workspace
- Network Operations: API calls, downloads, external service interactions
- Configuration Changes: Modifying system configs, environment variables
- Database Operations: Schema changes, data migrations, backup/restore

## ✅ Can Proceed Without Approval:
- Code Changes: Adding/editing code files in current workspace
- Using the stage0 CLI and npm/pipenv commands
- Test Execution: Running tests (as long as they don't modify data)
- Documentation: Adding comments, updating README files
- Simple File Operations: Creating or Moving files in current workspace

## 🤔 Ask for Clarification When:
- Unsure about scope or impact
- Request is ambiguous about intent
- For destructive operations, use format:

## ⚠️ DESTRUCTIVE OPERATION: [description of what will be deleted/changed]
- Risk: [specific data/functionality that will be lost] Proceed? (y/n)

## 📝 We have a Greenfield workflow that is for the initial creation of a codebase. During this workflow we are working directly in the main branch of the repo, and making regular commits. When working with a Deployable codebase we use a feature-branch workflow.

Deployable code bases are currently stage0, stage0_py_utils, stage0_mongodb_api, stage0_mongodb_spa, stage0_search_api, stage0_runbooks (merge, grade, evaluate), and stage0_template_mongodb_api.

## 🌾 Green Field Workflow
- Review rough requirements in PROGRESS.md
- Identify any missing information that will be needed to generate the code.
- Conduct an interview with me, one question at a time, to help answer questions about requirements.
- Document a development plan in the PROGRESS.md file and review with me before proceeding.
- The plan should identify Phases that are reviewed by me before proceeding to the next phase.
- Phases should break down into Steps that are committed when complete.
- You should update the PROGRESS.md file with notes after each commit. 
- We want to reach a deployable prototype as quickly as possible, then we will shift to the deployable codebase workflow.

## 🔄 Deployable Codebase Workflow
- Create a branch to add a feature or correct a defect.
- If this is a defect, add unit testing to demonstrate defect first and commit those changes.
- Make code changes, add/update unittest till passing.
- Add/update end-2-end testing till passing - See README for developer commands
- Commit changes and publish branch.
- Notify me that the code changes are ready for review.
- After changes have been reviewed and merged by me, fetch the updated main branch. 
- If the feature was a step in a larger plan, record PROGRESS.md and proceed to next feature/defect.

NOTE: All work on stage0 is still pre-release, so maintaining backward compatibility is far less important that simplicity and maintainability.