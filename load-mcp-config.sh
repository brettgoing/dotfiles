#!/bin/bash

# Script to load MCP servers to Claude Code user scope
# Uses claude mcp add-json commands with user confirmation

set -e

# Show usage if --help is passed
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0 [CONFIG_FILE]"
    echo ""
    echo "Load MCP servers from a JSON configuration file to Claude Code user scope."
    echo ""
    echo "Arguments:"
    echo "  CONFIG_FILE    Path to MCP configuration file (default: .mcp.json)"
    echo ""
    echo "The configuration file should contain an 'mcpServers' object with server definitions."
    echo ""
    echo "Example:"
    echo "  $0                    # Load from .mcp.json in current directory"
    echo "  $0 my-servers.json    # Load from specific file"
    exit 0
fi

# Use provided file argument or default to .mcp.json in current directory
MCP_CONFIG_FILE="${1:-.mcp.json}"

# Check if config file exists
if [[ ! -f "$MCP_CONFIG_FILE" ]]; then
    echo "Error: $MCP_CONFIG_FILE not found"
    exit 1
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed"
    exit 1
fi

# Check if claude command is available
if ! command -v claude &> /dev/null; then
    echo "Error: claude command is not available"
    exit 1
fi

echo "Loading MCP servers from $MCP_CONFIG_FILE"
echo "Each server will be added to user scope using 'claude mcp add-json'"
echo ""

# Get list of server names
servers=$(jq -r '.mcpServers | keys[]' "$MCP_CONFIG_FILE")

if [[ -z "$servers" ]]; then
    echo "No MCP servers found in configuration file"
    exit 0
fi

# Process each server
for server_name in $servers; do
    echo "----------------------------------------"
    echo "Server: $server_name"

    # Extract server configuration
    server_config=$(jq -c ".mcpServers[\"$server_name\"]" "$MCP_CONFIG_FILE")

    # Build the command
    cmd="claude mcp add-json --scope user '$server_name' '$server_config'"

    echo "Command to run:"
    echo "  $cmd"
    echo ""

    # Prompt for confirmation
    read -p "Execute this command? (y/n): " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Executing..."
        if eval "$cmd"; then
            echo "✓ Successfully added $server_name"
        else
            echo "✗ Failed to add $server_name"
        fi
    else
        echo "Skipped $server_name"
    fi
    echo ""
done

echo "Finished processing MCP servers"