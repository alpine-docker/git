### docker-git-alpine

A useful simple git container running in alpine Linux, especially for tiny Linux distro, such as RancherOS, which doesn't have a package manager.

[![DockerHub Badge](http://dockeri.co/image/alpine/git)](https://hub.docker.com/r/alpine/git/)

### Additional notes about multi-arch images

This feature was added on 23th May 2021.

1. Version v2.30.2 and 1.0.30 are manually pushed by me with multi-arch image supported
2. Older version will be not updated as multi-arch images
3. Newer vesions from now on will be multi-arch images (`--platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/arm/v6,linux/ppc64le,linux/s390x`)
4. I don't support other architectures, except `amd64`, because I have no other environment to do that. If you have any issues with other arch, you need raise PR to fix it.
5. There would be no difference for `docker pull` , `docker run` command with other arch, you can run it as normal. For example, if you need pull image from arm (such as new Mac M1 chip), you can run `docker pull alpine/git:v2.30.2` to get the image directly.

### Github Repo

https://github.com/alpine-docker/git

### Travis CI build logs

https://app.travis-ci.com/github/alpine-docker/git

### Docker image tags

https://hub.docker.com/r/alpine/git/tags/

Notes:

New tags with non-root user in image has been created.

```
alpine/git:<version>-user
alpine/git:user
```
Its uid and gid in container are 1000
```
$ docker run -ti --rm --entrypoint=id alpine/git:user
uid=1000(git-user) gid=1000(git-user)
```
Docker build from feature branch `feature/non-root`

### usage

    docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git <git_command>

For example, if you need clone this repository, you can run

    docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git clone https://github.com/alpine-docker/git.git
    
### Optional usage 1:

To save your type, add this fuction to `~/.bashrc` or `~/.profile`
    
    $ cat ~/.profile
    
    ...
    
    function git () {
        (docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git "$@")
    }
    
    ...
    
    $ source ~/.profile

for example, if you need clone this repository, with the function you just set, you can run it as local command

    git clone https://github.com/alpine-docker/git.git

### Optional usage 2:

    alias git="docker run -ti --rm -v $(pwd):/git -v $HOME/.ssh:/root/.ssh alpine/git"
    
#### NOTES:

- You need redefine (re-run) the alias, when you switch between different repositories
- You need run above alias command only under git repository's root directory.

## Demo

    $ cd application
    $ alias git="docker run -ti --rm -v $(pwd):/git -v $HOME/.ssh:/root/.ssh alpine/git"
    $ git clone git@github.com:YOUR_ACCOUNT/YOUR_REPO.git
    $ cd YOUR_REPO
    $ alias git="docker run -ti --rm -v $(pwd):/git -v $HOME/.ssh:/root/.ssh alpine/git"
    # edit several files
    $ git add . 
    $ git status
    $ git commit -m "test"
    $ git push -u origin master
    
### The Protocols

Supports git, http/https and ssh protocols.

Refer:
[Git on the Server - The Protocols](https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols)

### Automation builds

Set Travis CI to run builds every month.
- build on latest alpine image
- build with latest git in the alpine image
- generate new tag for this image
- generate git's version as image tag as well (`v${GIT_VERSION}`)
- update `latest` tag for this image
