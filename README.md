# 🚀 Nginx + Certbot Easy Domain Adder

A lightning-fast bash script that automates the process of adding domains to your Nginx server with automatic SSL certificate generation. Perfect for quickly setting up new subdomains with SSL certificates and reverse proxy configuration.

## ✨ Features

- 🔥 One-command domain/subdomain addition with reverse proxy setup
- 🔒 Automatic SSL certificate generation via Let's Encrypt
- ⚡ Instant Nginx configuration with secure defaults
- 🛡️ Automatic HTTP to HTTPS redirection
- 🔄 Handles Nginx service restart
- 💪 Root permission checking and error handling

## 🚀 Quick Start

### Prerequisites

- Nginx
- Certbot
- Root/sudo access
- Bash shell

### Installing Prerequisites

1. Install Snap (if not already installed):
```bash
# For Debian/Ubuntu
sudo apt update && sudo apt install snapd

# For CentOS/RHEL
sudo dnf install epel-release
sudo dnf install snapd
sudo systemctl enable --now snapd.socket

# For Fedora
sudo dnf install snapd
sudo systemctl enable --now snapd.socket

# For Arch Linux
sudo pacman -S snapd
sudo systemctl enable --now snapd.socket
```

2. Install Certbot via Snap:
```bash
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

### Installation

1. Clone the repository:
```bash
git clone https://github.com/harryeffinpotter/nginx-domain-adder.git
cd nginx-domain-adder
chmod +x setup.sh
sudo ./setup.sh
```

4. During setup, you'll be prompted for an email address for Let's Encrypt certificate registration.

### Usage

Add a new domain with its corresponding service port:
```bash
sudo add-domain yourdomain.com 8080
```

For subdomains:
```bash
sudo add-domain sub.yourdomain.com 3000
```

## 🛠️ How It Works

1. The script checks for root privileges
2. Attempts to obtain an SSL certificate using Certbot
3. Creates a new Nginx configuration file using the template
4. Sets up reverse proxy to forward requests to your specified port
5. Restarts Nginx to apply changes

## 📁 Project Structure

- `add_domain.sh`: Main script for adding domains
- `nginx_template.conf`: Template for Nginx server blocks
- `setup.sh`: Installation script
- `nginx.conf`: Base Nginx configuration
- `.env`: Stores your email for Let's Encrypt

## 🔧 Configuration Details

The Nginx configuration includes:
- Automatic HTTP to HTTPS redirection
- Modern SSL protocols (TLSv1.2, TLSv1.3)
- Proper proxy headers for reverse proxy
- Let's Encrypt SSL certificate integration

## 🚨 Troubleshooting

If Certbot fails:
1. The script will offer to create the Nginx configuration anyway
2. You can manually run certbot for the domain later
3. Check the domain's DNS settings are properly configured

## 📝 License

This project is open source and available under the MIT License.

---
Made with ❤️ and 🍆 by [harryeffinpotter](https://github.com/harryeffinpotter)
