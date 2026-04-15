# ai-ollama-hosting
POC for ollma private llm hosting

# Login Azure in devcontainer

```bash
# Install Az
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# Login
az login --use-device-code
```

# After setup access ollama and webUI endpoint

1. Ollama

```bash
curl http://4.180.74.203:11434/api/chat -d '{
  "model": "llama3",
  "messages": [{ "role": "user", "content": "Hello!" }]
}'
```

2. Chat WebUI: http://4.180.74.203:3000 (add new connection of the public endpoint of Ollama)