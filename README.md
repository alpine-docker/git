### docker-git-alpine

A useful simple git container running in alpine Linux, especially for tiny Linux distro, such as RancherOS, which doesn't have a package manager.

### usage

    docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git <git_command>

For example, if you need clone this repository, you can run

    docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git clone https://github.com/alpine-docker/git.git
    
### Optional usage 1:

To save your type, add this fuction to `~/.bashrc` or `~/.profile`
    
    $ cat ~/.profile
    
    ...
    
    function git () {
        (docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git $@)
    }
    
    ...
    
    $ source ~/.profile

for example, if you need clone this repository, with the function you just set, you can run it as local command

    git clone https://github.com/alpine-docker/git.git

### Optional usage 2:

    alias git="docker run -ti --rm -v $(pwd):/git alpine/git"
    
#### NOTES:

You need redefine it when you switch between different repositories 

### The Protocols

Supports git, http/https and ssh protocols.

Refer:
[Git on the Server - The Protocols](https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols)
