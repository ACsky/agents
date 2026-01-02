# Claude Code Plugin Installer PowerShell Script
# This script will install all 63 plugins from the wshobson/agents marketplace

Write-Host "Claude Code Plugin Installer" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host ""

# Check if we're in the correct directory
if (-not (Test-Path ".claude-plugin/marketplace.json")) {
    Write-Host "Error: marketplace.json not found. Make sure you're in the agents directory." -ForegroundColor Red
    exit 1
}

# Load plugin names
try {
    $marketplaceData = Get-Content ".claude-plugin/marketplace.json" | ConvertFrom-Json
    $plugins = $marketplaceData.plugins.name
    Write-Host "Found $($plugins.Count) plugins to install:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $plugins.Count; $i++) {
        Write-Host "  $($i + 1). $($plugins[$i])"
    }
}
catch {
    Write-Host "Error loading plugin names: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Starting plugin installation..." -ForegroundColor Yellow
Write-Host ""

$successCount = 0
$totalCount = $plugins.Count

# Install each plugin
for ($i = 0; $i -lt $plugins.Count; $i++) {
    $plugin = $plugins[$i]
    $progress = "[$($i + 1)/$totalCount]"

    Write-Host "$progress Installing $plugin..." -ForegroundColor Cyan

    try {
        # Execute the plugin installation command
        $result = & claude -p "/plugin install $plugin" 2>&1

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✓ Successfully installed $plugin" -ForegroundColor Green
            $successCount++
        }
        else {
            Write-Host "✗ Failed to install $plugin" -ForegroundColor Red
            Write-Host "  Error: $result" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "✗ Error installing ${plugin}: ${_}" -ForegroundColor Red
    }

    # Small delay to avoid overwhelming the system
    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "Successfully installed: $successCount/$totalCount plugins" -ForegroundColor Yellow

if ($successCount -lt $totalCount) {
    Write-Host "Some plugins failed to install. Check the errors above." -ForegroundColor Red
    exit 1
}
else {
    Write-Host "All plugins installed successfully!" -ForegroundColor Green
}