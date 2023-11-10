# server_deployment_script
A very simple, easy and quick way to deploy essential services and containers to most server enviornments via a Bash script. Primarily centered on docker containers. I probably should be using Ansible for this, but whatever.
These are fairly universal containers that I use on pretty much every server. This script uses APT package manager, as I pretty much only use Debian-based OS's for server deployments.

*"What and why?"*

So much faster than manually installing everything. Without needing to use/know Ansible. (Automation software.)
- Portainer: A nice GUI for docker containers. Makes it easier to deploy newer ones and is lightweight.
- PostgreSQL: Almost always find some use for a database. PostgreSQL is just one that has performed best for me. MySQL, MariaDB, especially in smaller enviornments are perfectly fine. Be sure to enter in your own credentials in the enviornment variables. (Check the server_deploy.sh file.)
- Wireguard: A VPN server. Will need configuration.
- Watchtower: An update utility to keep containers up to date and secure. The container is setup to execute updates every 24 hours.

If you don't want specific containers listed, this script will ask. Just respond to the prompt and enter "N" for no and "Y" for yes.

Instructions:

Grab the file from Github:
```bash
git clone https://github.com/epoch-philosophy/serverdeploymentscript.git
```
*or use wget:*
```
wget https://github.com/epoch-philosophy/serverdeploymentscript/blob/main/server_deploy.sh
```
Make the script executable:

```
chmod +x server_deploy.sh
```

Now execute the script:
```
./server_deploy.sh
```

Enjoy. (Hopefully.) Feel free to change this or do whatever with it.
