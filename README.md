# Docker Apache-Php
**This is my first attempt at making a docker and even an automated-build one. This is mostly a Cheatsheet for myself but if it helps you I'm glad**

It creates an Apache 2 Server with Php 5 integrated on debian/jessie.
To launch it you preferably want to use a Storage docker (e.g. the one I made - [t4keo/storage](https://github.com/t4keo/storage)).

Later on I may try to create a docker that does a all-in-one package if this is possible. I'm pretty new to this so I'm not sure.

## How to launch it
To launch this docker you just have to use one command in order to make it work in background :

``` sh
$ docker run -id -p 80:80 -p 443:443 --name apache-php t4keo/apache-php
```
* The -id is used to launch the container in interactive and detached mode
* The -p 80:80 and -p 443:443 is used to link the container port to the server port
* the --name option is used to give a comprehensive name to the container

If you want to use a storage docker, which is recommended, just attach it with the --volume-from option and enter the container name (e.g. storage)

``` sh
$ docker run -id -p 80:80 -p 443:443 --volumes-from storage --name apache-php t4keo/apache-php
```
* the --volume-from [container name] is used to link the storage container to the apache-php container

Finally if you want to enter in the container to work on it, just use the command below :

``` sh
$ docker exec -it apache-php bash
```
* -it is used to enter interactive mode and show the terminal
