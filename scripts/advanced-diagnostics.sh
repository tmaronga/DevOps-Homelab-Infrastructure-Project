#!/usr/bin/env bash
set -euo pipefail

echo "=== System Info ==="
uname -a
lsb_release -a 2>/dev/null || true
uptime

echo -e "\n=== Disk & Memory ==="
df -h
free -h

echo -e "\n=== Docker Status ==="
if command -v docker &> /dev/null; then
  docker --version
  docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" || true
else
  echo "Docker not installed."
fi

echo -e "\n=== K3s / Kubernetes ==="
if command -v kubectl &> /dev/null; then
  kubectl get nodes -o wide || true
  kubectl get pods --all-namespaces || true
else
  echo "kubectl not installed."
fi

echo -e "\n=== Network Info ==="
ip a
ip route
ss -tlnp || true

echo -e "\n=== Tailscale ==="
if command -v tailscale &> /dev/null; then
  sudo tailscale status || true
else
  echo "tailscale not installed."
fi

echo -e "\n=== Logs (last 50 lines of K3s) ==="
sudo journalctl -u k3s -n 50 --no-pager || true

echo -e "\nDiagnostics complete."
