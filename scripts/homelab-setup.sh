#!/usr/bin/env bash
set -euo pipefail

echo "==> Homelab setup script (Phase 1)"

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
if ! command -v docker &> /dev/null; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
else
  echo "Docker already installed."
fi

# Install Portainer
if ! docker ps | grep -q portainer; then
  docker volume create portainer_data || true
  docker run -d -p 9443:9443 -p 9000:9000 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data portainer/portainer-ce
fi

echo "==> Setup complete. Log out/in to apply docker group changes."
