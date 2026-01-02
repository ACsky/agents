#!/usr/bin/env python3
"""
Script to install all Claude Code plugins from wshobson/agents marketplace
"""

import json
import subprocess
import sys
import time

def load_plugin_names():
    """Load all plugin names from the marketplace.json file"""
    try:
        with open('.claude-plugin/marketplace.json', 'r') as f:
            data = json.load(f)
        return [plugin['name'] for plugin in data['plugins']]
    except Exception as e:
        print(f"Error loading plugin names: {e}")
        return []

def install_plugin(plugin_name):
    """Install a single plugin using slash command"""
    try:
        # Create a temporary script with the slash command
        cmd = f'/plugin install {plugin_name}'

        # Use echo to pipe the command to claude
        process = subprocess.Popen(
            ['echo', cmd],
            stdout=subprocess.PIPE,
            text=True
        )

        # Pipe to claude
        claude_process = subprocess.Popen(
            ['claude', '-p'],
            stdin=process.stdout,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )

        process.stdout.close()
        stdout, stderr = claude_process.communicate()

        print(f"Installing {plugin_name}...")
        if claude_process.returncode == 0:
            print(f"✓ Successfully installed {plugin_name}")
            return True
        else:
            print(f"✗ Failed to install {plugin_name}: {stderr}")
            return False

    except Exception as e:
        print(f"✗ Error installing {plugin_name}: {e}")
        return False

def main():
    """Main installation function"""
    print("Claude Code Plugin Installer")
    print("=" * 40)
    print("Installing all 63 plugins from wshobson/agents marketplace...")

    # Load plugin names
    plugins = load_plugin_names()
    if not plugins:
        print("No plugins found. Make sure you're in the agents directory.")
        sys.exit(1)

    print(f"Found {len(plugins)} plugins to install:")
    for i, plugin in enumerate(plugins, 1):
        print(f"  {i}. {plugin}")

    print("\nStarting installation...")

    # Install plugins with a small delay between each
    success_count = 0
    for i, plugin in enumerate(plugins, 1):
        print(f"\n[{i}/{len(plugins)}] Installing {plugin}...")
        if install_plugin(plugin):
            success_count += 1

        # Small delay to avoid overwhelming the system
        time.sleep(0.5)

    print(f"\nInstallation complete!")
    print(f"Successfully installed: {success_count}/{len(plugins)} plugins")

    if success_count < len(plugins):
        print("Some plugins failed to install. Check the errors above.")
        sys.exit(1)
    else:
        print("All plugins installed successfully!")

if __name__ == "__main__":
    main()