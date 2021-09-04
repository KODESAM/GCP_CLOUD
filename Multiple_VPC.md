######  Multiple VPC Networks #####

##  Create the managementnet network

## Run the following command to create the managementnet network:
```
gcloud compute networks create managementnet --project=qwiklabs-gcp-00-bb02bcb9a9e0 --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional 

```
## Run the following command to create the managementnet-us subnet:
```
gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-00-bb02bcb9a9e0 --range=10.130.0.0/20 --network=managementnet --region=us-central1

```
## Create the privatenet network

## Run the following command to create the privatenet network:

```
gcloud compute networks create privatenet --subnet-mode=custom

```
## Run the following command to create the privatesubnet-us subnet:

```
gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-central1 --range=172.16.0.0/24

```
## Run the following command to create the privatesubnet-eu subnet:

```
gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west4 --range=172.20.0.0/20

```
 ## Run the following command to list the available VPC networks:
 
```
gcloud compute networks list

```
```
NAME           SUBNET_MODE  BGP_ROUTING_MODE  IPV4_RANGE  GATEWAY_IPV4
default        AUTO         REGIONAL
managementnet  CUSTOM       REGIONAL
mynetwork      AUTO         REGIONAL
privatenet     CUSTOM       REGIONAL

```
```
gcloud compute networks subnets list --sort-by=NETWORK
```
```
NAME                 REGION                   NETWORK        RANGE          STACK_TYPE  IPV6_ACCESS_TYPE  IPV6_CIDR_RANGE  EXTERNAL_IPV6_CIDR_RANGE
default              us-central1              default        10.128.0.0/20  IPV4_ONLY
default              europe-west1             default        10.132.0.0/20  IPV4_ONLY
default              us-west1                 default        10.138.0.0/20  IPV4_ONLY
default              asia-east1               default        10.140.0.0/20  IPV4_ONLY
.
.

```
## Create the firewall rules for managementnet

## Create firewall rules to allow SSH, ICMP, and RDP ingress traffic to VM instances on the managementnet network.
```
gcloud compute --project=qwiklabs-gcp-00-bb02bcb9a9e0 firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0

```
## Create the firewall rules for privatenet
   
## create the privatenet-allow-icmp-ssh-rdp firewall rule:
```
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

```
## Run the following command to list all the firewall rules (sorted by VPC network):
```
gcloud compute firewall-rules list --sort-by=NETWORK

``` 
NAME                              NETWORK        DIRECTION  PRIORITY  ALLOW                         DENY  DISABLED
default-allow-icmp                default        INGRESS    65534     icmp                                False
default-allow-internal            default        INGRESS    65534     tcp:0-65535,udp:0-65535,icmp        False
default-allow-rdp                 default        INGRESS    65534     tcp:3389                            False
default-allow-ssh                 default        INGRESS    65534     tcp:22                              False
managementnet-allow-icmp-ssh-rdp  managementnet  INGRESS    1000      tcp:22,tcp:3389,icmp                False
mynetwork-allow-icmp              mynetwork      INGRESS    1000      icmp                                False
mynetwork-allow-rdp               mynetwork      INGRESS    1000      tcp:3389                            False
mynetwork-allow-ssh               mynetwork      INGRESS    1000      tcp:22                              False
privatenet-allow-icmp-ssh-rdp     privatenet     INGRESS    1000      icmp,tcp:22,tcp:3389                False

## Create VM instances

## Create the managementnet-us-vm instance:

## [managementnet-us-vm in managementsubnet-us]

```
gcloud compute instances create managementnet-us-vm --project=qwiklabs-gcp-00-bb02bcb9a9e0 --zone=us-central1-f --machine-type=n1-standard-1 \
--network-interface=network-tier=PREMIUM,subnet=managementsubnet-us --maintenance-policy=MIGRATE \
--service-account=859458891060-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--image=debian-10-buster-v20210817 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-balanced \
--boot-disk-device-name=managementnet-us-vm --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
```
## Create the privatenet-us-vm instance

## [privatenet-us-vm in privatesubnet-us]
```
gcloud compute instances create privatenet-us-vm --zone=us-central1-f --machine-type=n1-standard-1 --subnet=privatesubnet-us
```
```
gcloud compute instances list --sort-by=ZONE
 
```
```
NAME                 ZONE            MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
mynet-eu-vm          europe-west4-c  n1-standard-1               10.164.0.2   34.91.48.32     RUNNING
managementnet-us-vm  us-central1-f   n1-standard-1               10.130.0.3   34.132.201.240  RUNNING
mynet-us-vm          us-central1-f   n1-standard-1               10.128.0.2   34.121.157.232  RUNNING
privatenet-us-vm     us-central1-f   n1-standard-1               172.16.0.2   35.223.160.94   RUNNING
```
## Create the VM instance with multiple network interfaces

## Create the vm-appliance instance with network interfaces in privatesubnet-us, managementsubnet-us and mynetwork. 
## The CIDR ranges of these subnets do not overlap, which is a requirement for creating a VM with multiple network interface controllers (NICs)
```
gcloud compute instances create vm-appliance --project=qwiklabs-gcp-00-bb02bcb9a9e0 --zone=us-central1-f --machine-type=n1-standard-4 \
--network-interface=network-tier=PREMIUM,subnet=privatesubnet-us --network-interface=network-tier=PREMIUM,subnet=managementsubnet-us \
--network-interface=network-tier=PREMIUM,subnet=mynetwork --maintenance-policy=MIGRATE --service-account=859458891060-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--image=debian-10-buster-v20210817 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-balanced --boot-disk-device-name=vm-appliance \
--no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
```
## Run the following command to list all the VM instances (sorted by zone):
```
gcloud compute instances list --sort-by=ZONE
```
```
NAME                 ZONE            MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP                       EXTERNAL_IP                                 STATUS
mynet-eu-vm          europe-west4-c  n1-standard-1               10.164.0.2                        34.91.48.32                                 RUNNING
managementnet-us-vm  us-central1-f   n1-standard-1               10.130.0.3                        34.132.201.240                              RUNNING
mynet-us-vm          us-central1-f   n1-standard-1               10.128.0.2                        34.121.157.232                              RUNNING
privatenet-us-vm     us-central1-f   n1-standard-1               172.16.0.2                        35.223.160.94                               RUNNING
vm-appliance         us-central1-f   n1-standard-4               172.16.0.3,10.130.0.4,10.128.0.3  34.122.151.175,34.132.153.201,108.59.80.29  RUNNING
```
```
[ssh mynet-us-vm]

student-00-10800e233a53@mynet-us-vm:~$ ping -c 3 34.91.48.32 { -> mynet-eu-vm EXTERNAL_IP : STATUS-OK} 
PING 34.91.48.32 (34.91.48.32) 56(84) bytes of data.
64 bytes from 34.91.48.32: icmp_seq=1 ttl=52 time=103 ms
64 bytes from 34.91.48.32: icmp_seq=2 ttl=52 time=102 ms
64 bytes from 34.91.48.32: icmp_seq=3 ttl=52 time=103 ms
--- 34.91.48.32 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 102.609/102.980/103.249/0.377 ms

student-00-10800e233a53@mynet-us-vm:~$ ping -c 3 34.132.201.240  { -> managementnet-us-vm EXTERNAL_IP : STATUS-OK} 
PING 34.132.201.240 (34.132.201.240) 56(84) bytes of data.
64 bytes from 34.132.201.240: icmp_seq=1 ttl=61 time=1.76 ms
64 bytes from 34.132.201.240: icmp_seq=2 ttl=61 time=2.04 ms
64 bytes from 34.132.201.240: icmp_seq=3 ttl=61 time=1.89 ms
--- 34.132.201.240 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.766/1.901/2.048/0.125 ms

student-00-10800e233a53@mynet-us-vm:~$ ping -c 3 35.223.160.94   { -> privatenet-us-vm  EXTERNAL_IP : STATUS-OK}
PING 35.223.160.94 (35.223.160.94) 56(84) bytes of data.
64 bytes from 35.223.160.94: icmp_seq=1 ttl=61 time=1.90 ms
64 bytes from 35.223.160.94: icmp_seq=2 ttl=61 time=2.06 ms
64 bytes from 35.223.160.94: icmp_seq=3 ttl=61 time=1.97 ms
--- 35.223.160.94 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 1.908/1.984/2.068/0.065 ms

student-00-10800e233a53@mynet-us-vm:~$ ping -c 3 10.164.0.2   { -> mynet-eu-vm  INTERNAL_IP : STATUS-OK}
PING 10.164.0.2 (10.164.0.2) 56(84) bytes of data.
64 bytes from 10.164.0.2: icmp_seq=1 ttl=64 time=110 ms
64 bytes from 10.164.0.2: icmp_seq=2 ttl=64 time=108 ms
64 bytes from 10.164.0.2: icmp_seq=3 ttl=64 time=108 ms
--- 10.164.0.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 108.789/109.235/110.010/0.669 ms

student-00-10800e233a53@mynet-us-vm:~$ ping -c 3 10.130.0.3   { -> managementnet-us-vm  INTERNAL_IP : STATUS- NOK}
PING 10.130.0.3 (10.130.0.3) 56(84) bytes of data.
--- 10.130.0.3 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2043ms

student-00-10800e233a53@mynet-us-vm:~$ ping -c 3  172.16.0.2   { -> privatenet-us-vm  INTERNAL_IP : STATUS- NOK}
PING 172.16.0.2 (172.16.0.2) 56(84) bytes of data.
--- 172.16.0.2 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2048ms

student-00-10800e233a53@mynet-us-vm:~$ ip route
default via 10.128.0.1 dev eth0 
10.128.0.1 dev eth0 scope link 
```
```
[ssh vm-appliance]

student-00-10800e233a53@vm-appliance:~$ ping -c 3 172.16.0.2  { -> managementnet-us-vm  INTERNAL_IP : STATUS- OK}
PING 172.16.0.2 (172.16.0.2) 56(84) bytes of data.
64 bytes from 172.16.0.2: icmp_seq=1 ttl=64 time=1.88 ms
64 bytes from 172.16.0.2: icmp_seq=2 ttl=64 time=0.232 ms
64 bytes from 172.16.0.2: icmp_seq=3 ttl=64 time=0.293 ms
--- 172.16.0.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 36ms
rtt min/avg/max/mdev = 0.232/0.800/1.877/0.762 ms
student-00-10800e233a53@vm-appliance:~$ 

student-00-10800e233a53@vm-appliance:~$ ping -c 1 privatenet-us-vm
PING privatenet-us-vm.us-central1-f.c.qwiklabs-gcp-00-bb02bcb9a9e0.internal (172.16.0.2) 56(84) bytes of data.
64 bytes from privatenet-us-vm.us-central1-f.c.qwiklabs-gcp-00-bb02bcb9a9e0.internal (172.16.0.2): icmp_seq=1 ttl=6
4 time=1.93 ms
--- privatenet-us-vm.us-central1-f.c.qwiklabs-gcp-00-bb02bcb9a9e0.internal ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.933/1.933/1.933/0.000 ms
student-00-10800e233a53@vm-appliance:~$ 

student-00-10800e233a53@vm-appliance:~$ ping -c 3 10.130.0.3  { -> privatenet-us-vm   INTERNAL_IP : STATUS- OK}
PING 10.130.0.3 (10.130.0.3) 56(84) bytes of data.
64 bytes from 10.130.0.3: icmp_seq=1 ttl=64 time=1.76 ms
64 bytes from 10.130.0.3: icmp_seq=2 ttl=64 time=0.235 ms
64 bytes from 10.130.0.3: icmp_seq=3 ttl=64 time=0.266 ms
--- 10.130.0.3 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 28ms
rtt min/avg/max/mdev = 0.235/0.754/1.761/0.712 ms
student-00-10800e233a53@vm-appliance:~$ 

student-00-10800e233a53@vm-appliance:~$ ping -c 3 10.128.0.2  { -> mynet-us-vm  INTERNAL_IP : STATUS- OK}
PING 10.128.0.2 (10.128.0.2) 56(84) bytes of data.
64 bytes from 10.128.0.2: icmp_seq=1 ttl=64 time=1.69 ms
64 bytes from 10.128.0.2: icmp_seq=2 ttl=64 time=0.237 ms
64 bytes from 10.128.0.2: icmp_seq=3 ttl=64 time=0.312 ms
--- 10.128.0.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 9ms
rtt min/avg/max/mdev = 0.237/0.745/1.686/0.666 ms


student-00-10800e233a53@vm-appliance:~$ ping -c 3 10.164.0.2  { -> mynet-eu-vm  INTERNAL_IP : STATUS- NOK}
PING 10.164.0.2 (10.164.0.2) 56(84) bytes of data.
--- 10.164.0.2 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 56ms


student-00-10800e233a53@vm-appliance:~$ ip route
default via 172.16.0.1 dev ens4 
10.128.0.0/20 via 10.128.0.1 dev ens6 
10.128.0.1 dev ens6 scope link 
10.130.0.0/20 via 10.130.0.1 dev ens5 
10.130.0.1 dev ens5 scope link 
172.16.0.0/24 via 172.16.0.1 dev ens4 
172.16.0.1 dev ens4 scope link 
```
