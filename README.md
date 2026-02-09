## For Synology NAS

### Install Git

1. Open **Package Center** on your DSM.
2. Search for "**Git Server**".
3. Click Install. This package provides the git command-line tool needed for mirroring

Alternatively, use the Git package from [SynoCommunity](https://synocommunity.com).

### Enable SSH (Required for Git)

1. Go to **Control Panel** > **Terminal & SNMP**.
2. Check **Enable SSH service** and set a port (default is 22).
3. Click **Apply**.

### Verify installation

1. Open **Terminal** (via DSM or an SSH client).
2. Test the commands:

```
curl --version
ssh --version
git --version
```

## Update your .env file

```
cat > "$HOME/.env" << 'EOF'
GITHUB_USER=your_username
GITHUB_TOKEN=your_personal_access_token
EOF
chmod 600 "$HOME/.env"
```

## Save the script to $HOME/mirror-github.sh and make it executable

```
chmod +x "$HOME/mirror-github.sh"
```

## Schedule with Task Scheduler in DSM

1. Go to **Control Panel** > **Task Scheduler** > **Create** > **Scheduled Task** > **User-defined script**
2. Command: `/bin/sh "$HOME/mirror-github.sh"`
3. Set schedule (e.g., every 30 minutes)
