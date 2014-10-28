# Oracle's Server JRE for Docker

> Non of these ppa forks, just the latest and greatest original version, directly from the lord himself.


## Disclaimer
FYI: By using this Docker image, you're accepting the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).

## How it works

While creating your Docker image, the oracle server jre is downloaded via wget and stored in `/opt/oracle-server-jre`.

After that, the `/opt/oracle-server-jre/bin/java` is symlinked to `/usr/bin/java`.

You should now be able to run `java` in your image.


## Usage from Docker Hub

To run the latest and greatest version of all times, you have to execute:
```bash
$ docker run martinseeler/oracle-server-jre
```

If you want to run a specific java version, just include the tag for the version you want:

```bash
$ docker run martinseeler/oracle-server-jre:1.8_25
```

## Usage in your image

Just set the `FROM` command in your own `Dockerfile` as follows:
```
FROM martinseeler/oracle-server-jre
```

This will pull the latest and greatest version of all times.

If you want a specifc version, include the tag to represent the java version:
```
FROM martinseeler/oracle-server-jre:1.8_20
```


## Build from source

If you want to build this docker image locally, you can do it with the following command:

```bash
$ docker build -t="martinseeler/oracle-server-jre" .
```

To see if everything is good, hit the following into your terminal:

```bash
$ docker run martinseeler/oracle-server-jre java -version
```

You should see something like this:

```
java version "1.8.0_25"
Java(TM) SE Runtime Environment (build 1.8.0_25-b17)
Java HotSpot(TM) 64-Bit Server VM (build 25.25-b02, mixed mode)
```

## Dependencies

The image is built on top of [phusion/baseimage](https://github.com/phusion/baseimage-docker).
