### Create a new instance with gcloud vi command line ###

In the Cloud Shell, use gcloud to create a new virtual machine instance from the command line
```
$ gcloud compute instances create gcelab2 --machine-type n1-standard-2 --zone us-central1-f
```
Expected output:

Created [...gcelab2].
```
NAME     ZONE           MACHINE_TYPE  ...    STATUS
gcelab2  us-central1-f  n1-standard-2 ...    RUNNING
```
To see all the defaults, run:
```
$ gcloud compute instances create --help
```
You can also use SSH to connect to your instance via gcloud. Make sure to add your zone, or omit the --zone flag if you've set the option globally:
```
$ gcloud compute ssh gcelab2 --zone us-central1-f
```
