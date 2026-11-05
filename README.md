# Microsoft AutoUpdate remover (macOS)

Stops Microsoft AutoUpdate and **moves** its files to a timestamped backup folder in your home folder (`~/MAU-backup-YYYYMMDD-HHMMSS`), so the change can be undone.

## Usage

```bash
sudo zsh remove-mau.sh
```

## What it moves

- `/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app`
- `/Library/LaunchAgents/com.microsoft.update.agent.plist`
- `/Library/PrivilegedHelperTools/com.microsoft.autoupdate.helper`
- `~/Library/Preferences/com.microsoft.autoupdate.fba.plist`, `com.microsoft.autoupdate2.plist`
- `~/Library/Caches/com.microsoft.autoupdate.fba`, `com.microsoft.autoupdate2`

The Office licensing helper is left alone, so activation keeps working.

## Undo

Move the files from the backup folder back to their original locations (with `sudo` for the `/Library` ones).

## Notes

Office will no longer update itself. Get updates from Microsoft's
[Office for Mac update history](https://learn.microsoft.com/en-us/officeupdates/update-history-office-for-mac) page. Installing an Office update may reinstall AutoUpdate; run the script again if so.
