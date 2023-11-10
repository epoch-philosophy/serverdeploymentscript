# server_deployment_script
A very simple, easy and quick way to deploy essential services and containers to most server enviornments via a Bash script. Primarily centered on docker containers. I probably should be using Ansible for this, but whatever.
These are fairly universal containers that I use on pretty much ever server.

"What and why?"
So much faster than manually installing everything.
Portainer: A nice GUI for docker containers. Makes it easier to deploy newer ones and is lightweight.
PostgreSQL: Almost always find some use for a database. PostgreSQL is just one that has performed best for me. MySQL, MariaDB, especially in smaller enviornments are perfectly fine. Be sure to enter in your own credentials in the enviornment variables. (Check the server_deploy.sh file.)
Wireguard: A VPN server. Will need configuration.
Watchtower: An update utility to keep containers up to date and secure. The container is setup to execute updates every 24 hours.
If you don't want specific containers listed, just enter "N" when prompted. If you do, enter "Y".
