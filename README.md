### docker-git-alpine

a useful simple git container running in alpine linux, especially for RancherOS which don't have package manager.

Notes: only useful to clone the git codes with https url. 

### usage

alias git="docker run -ti --rm -v $(pwd):/git bwits/docker-git-alpine"

for example, if you need clone this repository, with the alias you just set, you can run it as local command

git clone https://github.com/BWITS/docker-git-alpine.git
