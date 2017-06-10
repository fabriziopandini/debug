# Overview

When working with resource management solutions, like kubernetes, mesos or swarm, often it is necessary to use a container as a "bridge" for getting into the cluster, and investigate a problem.

fabriziopandini/pause is a container that hangs waiting for SIGTERM, thus allowing to use kubectl exec or docker exec for debugging problems kubernetes, mesos or swarm by invoking tools into the container.

The container exists in many variants:

:latest, :latest-alpine
:latest-ubuntu

All variants contains following tools useful for debugging:
- curl
- jq (see https://stedolan.github.io/jq/)
- httpie (see https://httpie.org/)

on alpine
- net-tools (arp, hostname, ifconfig, netstat, rarp, route, plipconfig, slattach, mii-tool and iptunnel and ipmaddr.)
- iputils (ping, traceroute6, etc.)

on ubuntu
- net-tools (arp, hostname, ifconfig, netstat, rarp, route, plipconfig, slattach, mii-tool and iptunnel and ipmaddr.)
- iputils-ping (ping) and iputils-tracepath (tracepath, traceroute6)
- dnsutils (dig, nslookup, nsupdate)

# Usage

## Kubernetes

## Docker

Using `docker exec` on a `fabriziopandini/debug` container running in background:

```bash

# start a debug instance in backgroud
$ docker run -d --name debug --rm fabriziopandini/debug  

# executing debug commands inside the running container
$ docker exec -t debug http 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' 
$ docker exec -t debug curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | docker exec -i debug jq '.[0] | {message: .commit.message, name: .commit.committer.name}'

```

Using an interactive `fabriziopandini/debug` container:

```bash

$ docker run -it --rm fabriziopandini/debug sh

# (from inside the container)
$ http 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' 
$ curl 'https://api.github.com/repos/stedolan/jq/commits?per_page=5' | jq '.[0] | {message: .commit.message, name: .commit.committer.name}'

```
