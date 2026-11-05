#!/bin/zsh
# Removes Microsoft AutoUpdate by MOVING its files to a backup folder (reversible).
# Run with: sudo zsh remove-mau.sh
set -u
U=$(stat -f %Su /dev/console)              # the logged-in user
H=$(dscl . -read /Users/$U NFSHomeDirectory | awk '{print $2}')
B="$H/MAU-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$B"

# Stop the agent and running updater
launchctl bootout gui/$(id -u $U) /Library/LaunchAgents/com.microsoft.update.agent.plist 2>/dev/null
pkill -f "Microsoft AutoUpdate" ; pkill -f "Microsoft Update Assistant"

for p in \
  "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app" \
  /Library/LaunchAgents/com.microsoft.update.agent.plist \
  /Library/PrivilegedHelperTools/com.microsoft.autoupdate.helper \
  "$H/Library/Preferences/com.microsoft.autoupdate.fba.plist" \
  "$H/Library/Preferences/com.microsoft.autoupdate2.plist" \
  "$H/Library/Caches/com.microsoft.autoupdate.fba" \
  "$H/Library/Caches/com.microsoft.autoupdate2"
do
  [ -e "$p" ] && mv "$p" "$B/" && echo "moved: $p"
done
chown -R "$U" "$B"
echo "Backup in: $B  (delete it once you're happy)"
