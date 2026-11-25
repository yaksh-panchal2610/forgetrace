
set -euo pipefail

DOMAIN="${1:?Usage: bash ec2-setup.sh <domain> <email>}"
EMAIL="${2:?Usage: bash ec2-setup.sh <domain> <email>}"
APP_DIR=/opt/forgetrace

echo "==> Updating system and installing Docker"
sudo dnf update -y
sudo dnf install -y docker cronie python3
sudo systemctl enable --now docker crond
sudo usermod -aG docker ec2-user

echo "==> Installing Docker Compose plugin"
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -fsSL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m)" \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

echo "==> Adding 2 GB swap (small instance safety net)"
if [ ! -f /swapfile ]; then
  sudo dd if=/dev/zero of=/swapfile bs=1M count=2048 status=none
  sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null
fi

echo "==> Installing Certbot"
sudo python3 -m venv /opt/certbot
sudo /opt/certbot/bin/pip install --quiet --upgrade pip certbot
sudo ln -sf /opt/certbot/bin/certbot /usr/bin/certbot

echo "==> Getting HTTPS certificate for ${DOMAIN} (port 80 must be open)"
sudo certbot certonly --standalone -d "${DOMAIN}" -m "${EMAIL}" --agree-tos --non-interactive

echo "==> Auto-renew certificate daily at 03:00"
echo "0 3 * * * root /usr/bin/certbot renew -q --pre-hook 'docker compose -f ${APP_DIR}/docker-compose.prod.yml stop nginx' --post-hook 'docker compose -f ${APP_DIR}/docker-compose.prod.yml start nginx'" \
  | sudo tee /etc/cron.d/certbot-renew > /dev/null

echo "==> Preparing ${APP_DIR}"
sudo mkdir -p "${APP_DIR}/nginx"
sudo chown -R ec2-user:ec2-user "${APP_DIR}"

echo ""
echo "Done. Log out and back in (for docker group), then create ${APP_DIR}/.env"