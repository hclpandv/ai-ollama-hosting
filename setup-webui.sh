# Install and setup docker runtime
sudo apt update
sudo apt install docker.io
sudo systemctl enable --now docker

# Run webUI in container (only for testing purpose)
sudo docker pull ghcr.io/open-webui/open-webui:main
sudo docker run -d -p 3000:8080 \
  -v open-webui:/app/backend/data \
  -v open-webui-ollama:/root/.ollama \
  --add-host host.containers.internal:host-gateway \
  --name open-webui \
  --restart always \
  ghcr.io/open-webui/open-webui:main