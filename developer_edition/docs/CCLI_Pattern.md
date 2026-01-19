# Containerized CLI Pattern

A standardized pattern for building containerized command-line tools that execute single-purpose tasks with deterministic outputs. See also: [Containerized Configuration as Code Pattern](./CCAC_Pattern.md)

## Core Architecture

```
Caller → [Mounts volumes] → Container → [output: varies] → Caller
```

The executor is a **pure function**: reads inputs from mounted volumes, executes one task, produces output (stdout, file modifications, or both), exits. All external operations (git, network, etc.) are handled by the caller.

## Standard Structure

```
src/
├── command.py      # CLI entry point (main() function)
├── config.py       # Configuration management (env vars → defaults)
├── executor.py     # Main orchestration logic
└── [providers/]    # Optional: provider abstractions (LLM, transcription, etc.)
```

### Entry Point Pattern (`command.py`)

1. Initialize `Config()` (configures logging automatically)
2. Validate required paths exist
3. Call `Executor.execute_task()` or equivalent
4. Output results (stdout, file modifications, or status messages)
5. Exit with appropriate code (0 = success, 1 = error)

### Configuration Pattern (`config.py`)

- Centralized `Config` class with typed configuration
- Priority: environment variables → defaults
- Automatic logging configuration via `LOG_LEVEL`
- Secret masking in `config_items` tracking
- Categories: `config_strings`, `config_ints`, `config_string_secrets`
- Default mount paths: `/workspace/[input|repo|context]`

### Executor Pattern (`executor.py`)

- Static methods for orchestration
- Provider abstraction via protocol/interface (optional)
- Input validation and error handling
- Structured logging throughout
- Returns structured output (string, tuple, etc.)

## Container Design

### Dockerfile Standard

```dockerfile
FROM python:3.12-slim
WORKDIR /opt/stage0/[executor|processor|transcriber]
COPY Pipfile Pipfile.lock* ./
RUN pip install pipenv && pipenv install --deploy --system
COPY src/ /opt/stage0/[name]/
ENV PYTHONPATH=/opt/stage0/[name]
ENTRYPOINT ["python", "-m", "command"]
```

### Execution Model

- **Non-interactive**: All configuration via environment variables
- **Stateless**: No persistent state between runs
- **Deterministic**: Same inputs → same outputs(-ish for LLM backed CLI's)
- **Container-first**: Designed for `docker run` with mounted volumes
- **Security**: Can run with `--network=none`, non-root user, limited resources

## Design Principles

1. **Pure Function**: One task, one run, one output
2. **Provider Abstraction**: External services via protocol interface (LLM, transcription, etc.)
3. **Non-interactive**: No prompts, all configuration via env vars
4. **Auditable**: Explicit task definitions, path allowlists, output contracts
5. **Testable**: Unit tests for components, E2E tests with containers

## Output Format

- **Simple Output**: Results written to stdout (not stderr), format documented in README
- **File Modification**: Files modified directly in mounted volumes, stdout for status
- **Error Handling**: Errors logged to stderr, exit code 1; Success: exit code 0

## Common Environment Variables

- `LOG_LEVEL`: Logging verbosity (default: INFO)
- `[TASK_NAME|INPUT_DIR|REPO_ROOT]`: Primary input path
- `[CONTEXT_ROOT|SPECIFICATIONS_FOLDER]`: Optional secondary input
- Provider-specific: `[LLM|TRANSCRIPTION]_PROVIDER`, `[LLM|TRANSCRIPTION]_API_URL`, etc.
