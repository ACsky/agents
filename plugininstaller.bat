@echo off
echo Installing Claude Code plugins from wshobson/agents marketplace...
echo.

REM Start Claude Code with installation commands
echo /plugin install python-development | claude
echo /plugin install javascript-typescript | claude
echo /plugin install backend-development | claude
echo /plugin install debugging-toolkit | claude
echo /plugin install code-documentation | claude

echo.
echo Plugin installation commands have been executed.
echo Note: Some plugins may require interactive confirmation.
pause