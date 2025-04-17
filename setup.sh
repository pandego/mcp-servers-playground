#!/bin/bash

# ------------------------------ #
# --- 1. ENVIRONMENT SETUP   --- #
# ------------------------------ #

echo "\n==========[ ENVIRONMENT SETUP ]=========="
echo "Sourcing environment variables from .env..."
if [ ! -f .env ]; then
    echo "[ERROR] .env file not found!"
    echo "[IMPORTANT] **YOU MUST CREATE A .env FILE BEFORE RUNNING THIS SCRIPT.**"
    echo "**Run: cp example.env .env**"
    echo "**Then edit .env and set all necessary variables, fool!**"
    exit 1
fi
. .env


# ------------------------------------------------ #
# --- 2. Add Secrets to the MCP Servers Config --- #
# ------------------------------------------------ #

echo "\n==========[ MCP SERVERS CONFIGURATION ]=========="
cp mcp_servers_config_example.json mcp_servers_config.json
echo "Creating and updating secrets in mcp_servers_config.json..."

# --- Notion --- #
sed -i '' "s|<notion-token>|${NOTION_TOKEN}|g" mcp_servers_config.json
sed -i '' "s|<notion-version>|${NOTION_VERSION}|g" mcp_servers_config.json

# --- Searxng --- #
sed -i '' "s|<searxng-url>|${SEARXNG_URL}|g" mcp_servers_config.json

# --- Memory --- #
sed -i '' "s|<memory-file-path>|${MEMORY_FILE_PATH}|g" mcp_servers_config.json

# --- Puppeteer --- #
sed -i '' "s|<puppeteer-browser-path>|${PUPPETEER_BROWSER_PATH}|g" mcp_servers_config.json
sed -i '' "s|<puppeteer-allow-dangerous>|${PUPPETEER_ALLOW_DANGEROUS}|g" mcp_servers_config.json


# ----------------------------- #
# --- 3. Pull Docker Images --- #
# ----------------------------- #

echo "\n==========[ DOCKER IMAGES ]=========="
echo "Building Docker images..."

# --- Notion --- #
if [ -d "notion-mcp-server" ]; then
    echo "Notion repository already exists. Skipping..."
else
    git clone https://github.com/makenotion/notion-mcp-server.git
fi
cd notion-mcp-server
docker compose build

# --- Maintained Servers --- #
cd ../modelcontextprotocol/servers
docker build -t mcp/puppeteer -f src/puppeteer/Dockerfile .
docker build -t mcp/memory -f src/memory/Dockerfile .
docker build -t mcp/sequentialthinking -f src/sequentialthinking/Dockerfile .
docker build -t mcp/filesystem -f src/filesystem/Dockerfile .
