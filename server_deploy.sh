#!/bin/bash

# Update System Repositories
sudo apt-get update
sudo apt-get upgrade -y

# Install Docker
sudo apt-get install -y docker.io

# Install Docker Compose
sudo apt-get install -y docker-compose

# Ensure Docker starts on boot
sudo systemctl enable docker

# Install OpenSSH Server (if not already installed)
sudo apt-get install -y openssh-server

# Create a Custom Docker Network
sudo docker network create proxy

# Initialize Docker Compose File
echo "version: '3'" > docker-compose.yml
echo "services:" >> docker-compose.yml

# Function to add a service to the Docker Compose file
add_service() {
    echo "  $1:" >> docker-compose.yml
    echo "$2" >> docker-compose.yml
    echo "" >> docker-compose.yml
}

# Portainer Configuration
portainer_config='
    image: portainer/portainer-ce:latest
    restart: unless-stopped
    networks:
      - proxy
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data'

# PostgreSQL Configuration: Add db name, user, and password
postgresql_config='
    image: postgre:latest
    restart: unless-stopped
    networks:
      - proxy
    environment:
      - POSTGRES_DB=
      - POSTGRES_USER=
      - POSTGRES_PASSWORD=
      - PUID=1000
      - PGID=1000
    volumes:
      - postgres_data:/config
    ports:
      - "5432:5432"'

# WireGuard Configuration
wireguard_config='
    image: linuxserver/wireguard:latest
    restart: unless-stopped
    networks:
      - proxy
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /lib/modules:/lib/modules
      - wireguard_config:/config
    ports:
      - "51820:51820/udp"
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1'

# Watchtower Configuration
watchtower_config='
    image: containrrr/watchtower:latest
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock'
    command: --interval 86400  

# Ask user for each service
read -p "Include Portainer? [Y/N] " include_portainer
if [[ $include_portainer == [Yy] ]]; then
    add_service "portainer" "$portainer_config"
fi

read -p "Include PostgreSQL? [Y/N] " include_postgresql
if [[ $include_postgresql == [Yy] ]]; then
    add_service "postgresql" "$postgresql_config"
fi

read -p "Include WireGuard? [Y/N] " include_wireguard
if [[ $include_wireguard == [Yy] ]]; then
    add_service "wireguard" "$wireguard_config"
fi

read -p "Include Watchtower? [Y/N] " include_watchtower
if [[ $include_watchtower == [Yy] ]]; then
    add_service "watchtower" "$watchtower_config"
fi

# Add network and volume definitions to Docker Compose file
cat <<EOF >> docker-compose.yml
networks:
  proxy:
    external: true

volumes:
  portainer_data:
  postgres_data:
  wireguard_config:
EOF

# Start Docker Containers
sudo docker-compose up -d
