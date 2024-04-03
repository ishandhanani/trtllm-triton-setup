#!/bin/bash

# Define the repository to clone and the commit or branch you want to checkout
REPO_URL="https://github.com/triton-inference-server/tensorrtllm_backend.git"
REPO_BRANCH="main"  # You can change this to a specific commit hash if needed

# Define the workspace directory that will contain the base directory
WORKSPACE_DIR="model_workspace"

# Define the base directory for your model repository
BASE_DIR="$WORKSPACE_DIR/brev_model_repository"

# Define the directories to create within the base directory
DIRS=("ensemble" "postprocessing" "preprocessing" "tensorrt_llm")

# Clone the repository
git clone --depth 1 --branch "$REPO_BRANCH" "$REPO_URL" tmp_repo

# Create the workspace and base directory
mkdir -p "$BASE_DIR"

# Create a new directory for tokenizer within the workspace directory
TOKENIZER_DIR="$WORKSPACE_DIR/tokenizer_dir"
mkdir -p "$TOKENIZER_DIR"

# Loop over the directories and populate them with the cloned content
for dir in "${DIRS[@]}"; do
  mkdir -p "$BASE_DIR/$dir"
  if [ -d "tmp_repo/all_models/inflight_batcher_llm/$dir" ]; then
    mv "tmp_repo/all_models/inflight_batcher_llm/$dir/"* "$BASE_DIR/$dir"
  fi
done

# Cleanup the temporary cloned repository
rm -rf tmp_repo

echo "Repository and tokenizer directory setup is complete."

