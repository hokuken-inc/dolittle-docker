dolittle-docker
==============

## Installation

1) Clone this repository

```bash
$ git clone git@github.com:hokuken-inc/dolittle-docker.git
$ cd dolittle-docker
```

2) Edit root password in Dockerfile
```bash
$ vi Dockerfile
```

Please change below `yourpassword`
`root:yourpassword`

3) build docker image

```
$ cd dolittle-docker
$ docker build .
```


### Tag

Check images

```
$ docker images
```

And tag image.

```
$ docker tag CONTAINER_ID TAG_NAME
```

## Run container

Run with connecting web and ssh ports.
```
$ docker run -d -p 4000:80 -p 2022:22 TAG_NAME
```

## Access server to a container (boot2docker)

Check host ip-address
```
$ boot2docker ip
```

Access web server
```
$ curl http://IP_ADDRESS:4000/
```

Connect SSH
```
$ ssh IP_ADDRESS -p 2022
```

