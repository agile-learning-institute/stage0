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
- Test Execution: Running tests (as long as they don't modify data)
- Documentation: Adding comments, updating README files
- Simple File Operations: Creating or Moving files in current workspace

## 🤔 Ask for Clarification When:
- Unsure about scope or impact
- Request is ambiguous about intent
- For destructive operations, use format:

## ⚠️ DESTRUCTIVE OPERATION: [description of what will be deleted/changed]
- Risk: [specific data/functionality that will be lost] Proceed? (y/n)

My preference: Automate normal workflow, but always ask before potentially destructive actions.