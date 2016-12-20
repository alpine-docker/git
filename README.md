### docker-git-alpine

a useful simple git container running in alpine linux, especially for tiny linux distro, such as RancherOS, which don't have package manager.

Notes: only useful to clone the git codes with https url. 

### usage
Add this to your .bashrc
    
    alias git="docker run -ti --rm -v ~/.ssh:/root/.ssh -v $(pwd):/git bwits/docker-git-alpine"

for example, if you need clone this repository, with the alias you just set, you can run it as local command

    git clone https://github.com/BWITS/docker-git-alpine.git

### The Protocols

Supports git, http/https and ssh protocols.

Refer:
[Git on the Server - The Protocols](https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols)
