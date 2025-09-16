# DevOps Homelab Infrastructure

A comprehensive DevOps homelab setup demonstrating Kubernetes (K3s), containerization, networking, and infrastructure management skills.

## Overview

This repository documents my journey building a production-ready homelab environment, showcasing practical DevOps skills including:

- Kubernetes cluster management with K3s
- Container orchestration and ingress configuration
- Network troubleshooting and diagnostics
- Infrastructure automation with bash scripts
- Documentation and knowledge sharing

## Quick Start

```bash
git clone git@github.com:tmaronga/DevOps-Homelab-Infrastructure-Project.git
cd DevOps-Homelab-Infrastructure-Project

# Run the setup script (review script before running)
chmod +x scripts/homelab-setup.sh
./scripts/homelab-setup.sh

# Run diagnostics
chmod +x scripts/advanced-diagnostics.sh
./scripts/advanced-diagnostics.sh

git clone git@github.com:tmaronga/DevOps-Homelab-Infrastructure-Project.git
cd DevOps-Homelab-Infrastructure-Project

# Run the setup script (review script before running)
chmod +x scripts/homelab-setup.sh
./scripts/homelab-setup.sh

# Run diagnostics
chmod +x scripts/advanced-diagnostics.sh
./scripts/advanced-diagnostics.sh
Edit the https://www.linkedin.com/in/tendayi-maronga/ lines to your actual contact info.

---

## 6. Add sample scripts (copy these into `scripts/`)

### 6.1 `scripts/homelab-setup.sh` — basic safe bootstrap
This script installs Docker, Portainer, Tailscale and K3s (review before running).

```bash
cat > scripts/homelab-setup.sh << 'EOF'
#!/usr/bin/env bash
set -euo pipefail

echo "==> Homelab setup script (read before running)"

# Update & basic deps
sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Install Docker (official)
if ! command -v docker &> /dev/null; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker "$USER"
else
  echo "Docker already installed"
fi

# Install Portainer (UI for containers)
docker volume create portainer_data || true
docker run -d -p 9443:9443 -p 9000:9000 --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data portainer/portainer-ce

# Install Tailscale (mesh VPN)
if ! command -v tailscale &> /dev/null; then
  echo "Installing Tailscale..."
  curl -fsSL https://tailscale.com/install.sh | sh
  echo "Run 'sudo tailscale up' and authenticate via the URL printed."
else
  echo "Tailscale already installed"
fi

# Install K3s (lightweight Kubernetes)
if ! command -v k3s &> /dev/null; then
  echo "Installing K3s (Lightweight Kubernetes)..."
  curl -sfL https://get.k3s.io | sh -
  echo "kubeconfig available at /etc/rancher/k3s/k3s.yaml (use sudo to access)"
else
  echo "K3s already installed"
fi

echo "==> Setup complete. Log out/in or restart shell to apply group changes."
echo "Note: Review and customize the script for production use."
Last updated: Tue Sep 16 06:00:43 PM CEST 2025
