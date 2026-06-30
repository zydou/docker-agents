# syntax=docker/dockerfile:1.7
FROM ghcr.io/zydou/docker-agents:base AS base

FROM base AS codex
ARG CODEX_NON_INTERACTIVE=true
ENV PATH="/root/.local/bin:${PATH}"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG CODEX_VERSION=latest
ENV CODEX_VERSION="$CODEX_VERSION"
RUN curl -fsSL https://chatgpt.com/codex/install.sh | bash -s -- --release "${CODEX_VERSION}"

FROM base AS claude
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG CLAUDE_CODE_VERSION=latest
ENV CLAUDE_CODE_VERSION="$CLAUDE_CODE_VERSION"
RUN curl -fsSL https://claude.ai/install.sh | bash -s -- "${CLAUDE_CODE_VERSION}"

FROM base AS latest
ARG CODEX_NON_INTERACTIVE=true
ENV PATH="/root/.local/bin:${PATH}"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ARG CODEX_VERSION=latest
RUN curl -fsSL https://chatgpt.com/codex/install.sh | bash -s -- --release "${CODEX_VERSION}"
ARG CLAUDE_CODE_VERSION=latest
ENV CODEX_VERSION="$CODEX_VERSION"
ENV CLAUDE_CODE_VERSION="$CLAUDE_CODE_VERSION"
RUN curl -fsSL https://claude.ai/install.sh | bash -s -- "${CLAUDE_CODE_VERSION}"
