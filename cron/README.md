# Register multiple crons

```crontab
cat *.cron | crontab
```

NOTE: We should grant `cron` Full Disk Access.

Go to System Preferences > Security & Privacy > Privacy > Full Disk Access

Click the Lock to make changes

Click the + icon

Press Command + Shift + G and type `/usr/sbin/cron` then press OK
