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

1. Open an SSH terminal
2. Test the commands:

```
curl --version
ssh -V
git --version
```

## Create a GitHub Personal Access Token

1. Navigate to [https://github.com/settings/tokens]
2. Select **Generate new token**
3. Give your token a descriptive name (e.g., "NAS Mirror")
4. Set an expiration date
5. Select the level of access
6. Add a **Contents** permission set to **Read-only**
7. Click **Generate token**

Copy the token immediately and store it securely (e.g., in a password manager). It will not be shown again
2

## Update your .env file

```
cat > "$HOME/.env" << 'EOF'
GITHUB_USER=your_username
GITHUB_PAT=your_personal_access_token
EOF
chmod 600 "$HOME/.env"
```

## Save the script to $HOME/bin/mirror-github.sh and make it executable

```
chmod u+x "$HOME/mirror-github.sh"
```

## Schedule with Task Scheduler in DSM

1. Go to **Control Panel** > **Task Scheduler** > **Create** > **Scheduled Task** > **User-defined script**
2. Command: `/bin/sh "$HOME/bin/mirror-github.sh"`
3. Set schedule (e.g., every 30 minutes)
