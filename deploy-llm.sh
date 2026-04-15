#!/bin/bash

#
# Script to deploy ollma run time and LLM / SLM
# 

set -e

export MODEL_NAME="llama3"   # or llama3-mini

# Install ollama
curl -fsSL https://ollama.com/install.sh | sh

# Start 
ollama start

# pull and start a small modle
ollama run ${MODEL_NAME}

# Perform test
# 
curl http://localhost:11434/api/chat -d '{
  "model": "llama3",
  "messages": [{ "role": "user", "content": "Hello!" }]
}'