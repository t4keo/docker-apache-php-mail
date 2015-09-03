# Docker Apache-Php-Exim
**This is my first attempt at making a docker and even an automated-build one. This is mostly a Cheatsheet for myself but if it helps you I'm glad**

It creates an Apache2 Server with PHP5( and Exim4) integrated on debian/jessie.
To launch it you preferably want to use a Storage docker (e.g. the one I made - [GitHub : t4keo/docker-storage](https://github.com/t4keo/docker-storage) - [Docker : t4keo/storage](https://hub.docker.com/r/t4keo/storage/)).

## What's in the box?
This image contains 4 versions depending on the tag you choose :
* "latest" or "storage-exim"
* "exim"
* "storage"
* "base"

### Why 4 versions?
So basically I made 4 versions of it depending on whether or not you want the storage link with and whether or not you want the exim4 mailserver integrated with. Although the tags are pretty easy to understand I'm gonna describe what does each container

#### "latest" or "storage-exim"
This container has the storage link and the exim4 mailserver integrated.

**Notice that the storage is linked with the /home/html folder so you'll first have to place the files in those folder to make it work.**

To launch it, you have to use this commmand :
``` sh
$ docker run -id -p 80:80 -p 443:443 -p 25:25 --volumes-from [storage container name] --name apache-php-exim t4keo/apache-php-exim:storage-exim
```

Moreover, you'll have to check for the **mailname** and **update-exim4.conf.conf** to modify some lines using your favourite editor.

First, go in your container
``` sh
$ docker exec -it apache-php-mail bash
```

Second, edit the mailname file (I'm using nano but use whatever you like)
``` sh
$ nano /etc/mailname
```

and change the line
``` sh
yourdomain.tld
```
by your domain name and your tld (e.g. if my domain name was docker I would write docker.com)

Third, edit the update-exim4.conf.conf file (I'm using nano but use whatever you like)
``` sh
$ nano /etc/exim4/update-exim4.conf.conf
```

and change the line
``` sh
dc_other_hostnames='yourdomain.tld; localhost.localdomain; localhost'
```
by replacing the yourdomain.tld by your domain name and your tld (e.g. if my domain name was docker I would write docker.com) which technically is the same as for the mailname file.

Then, restart the exim4 server with this command 
``` sh
$ service exim4 restart
```

and finally exit the container with 
``` sh
$ exit
```
Everything should work okay starting from there

I'm gonna try to automate this part later

#### "exim"
If you use the exim version, just do the same step as above to configure the exim server, the storage container isn't linked on this version so you'll have to place your website file with another way.

To launch it, you have to use this commmand :
``` sh
$ docker run -id -p 80:80 -p 443:443 -p 25:25 --name apache-php-exim t4keo/apache-php-exim:exim
```

#### "storage"
This is the storage version only, just run it using the command underneath :
``` sh
$ docker run -id -p 80:80 -p 443:443 --volumes-from [storage container name] --name apache-php t4keo/apache-php-exim:storage
```
**Notice that the storage is linked with the /home/html folder so you'll first have to place the files in those folder to make it work.**

#### "base"
This is just the base which is an Apache2 PHP5 webserver container.

To launch this docker you just have to use one command in order to make it work in background :
``` sh
$ docker run -id -p 80:80 -p 443:443 --name apache-php t4keo/apache-php-exim:base
```

## How to launch it
To launch this docker you just have to use one command in order to make it work in background :

``` sh
$ docker run -id -p 80:80 -p 443:443 (if exim4 with add  -p 25:25 see above) --name apache-php t4keo/apache-php-exim:[tag]
```
* The -id is used to launch the container in interactive and detached mode
* The -p 80:80 and -p 443:443 is used to link the container apache port to the server port
* The -p 25:25 is used to link the container exim4 port to the server port
* the --name option is used to give a comprehensive name to the container

If you want to use a storage docker, which is recommended, just attach it with the --volume-from option and enter the container name (e.g. storage)

``` sh
$ docker run -id -p 80:80 -p 443:443  (if exim4 with add  -p 25:25 see above) --volumes-from storage --name apache-php t4keo/apache-php-exim:[tag]
```
* the --volume-from [container name] is used to link the storage container to the apache-php container

Finally if you want to enter in the container to work on it, just use the command below :

``` sh
$ docker exec -it [container name] bash
```
* -it is used to enter interactive mode and show the terminal
