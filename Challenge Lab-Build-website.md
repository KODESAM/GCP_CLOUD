###  Welcome to Cloud Shell! Type "help" to get started. ######
Your Cloud Platform project in this session is set to qwiklabs-gcp-01-07eed6bf7f22.
Use “gcloud config set project [PROJECT_ID]” to change to a different project.
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-07eed6bf7f22)$ git clone https://github.com/googlecodelabs/monolith-to-microservices.git

```
```
Cloning into 'monolith-to-microservices'...
remote: Enumerating objects: 988, done.
remote: Counting objects: 100% (52/52), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 988 (delta 39), reused 0 (delta 0), pack-reused 936
Receiving objects: 100% (988/988), 2.82 MiB | 10.45 MiB/s, done.
Resolving deltas: 100% (440/440), done.
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-07eed6bf7f22)$ ls -l
total 8
drwxr-xr-x 7 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  2 03:46 monolith-to-microservices
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f  913 Sep  2 03:45 README-cloudshell.txt
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-07eed6bf7f22)$ cd monolith-to-microservices/
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-07eed6bf7f22)$ ls -l
total 40
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1100 Sep  2 03:46 CONTRIBUTING.md
-rwxr-xr-x 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1348 Sep  2 03:46 deploy-monolith.sh
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f  552 Sep  2 03:46 LICENSE
drwxr-xr-x 2 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  2 03:46 logs
drwxr-xr-x 3 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  2 03:46 microservices
drwxr-xr-x 5 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  2 03:46 monolith
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f   27 Sep  2 03:46 package-lock.json
drwxr-xr-x 5 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  2 03:46 react-app
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 3321 Sep  2 03:46 README.md
-rwxr-xr-x 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1372 Sep  2 03:46 setup.sh

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud config set compute/zone us-central1-a
```
```
Updated property [compute/zone].
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-07eed6bf7f22)$ ./setup.sh

```
```
Checking for required npm version...Completed.
Installing monolith dependencies...Completed.
Installing microservies dependencies...Completed.
Installing React app dependencies...Completed.
Building React app and placing into sub projects...Completed.

Script completed successfully!

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-07eed6bf7f22)$ cd microservices

student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices (qwiklabs-gcp-01-07eed6bf7f22)$ npm start
```
```
> microservices@1.0.0 start
> concurrently "npm run frontend" "npm run products" "npm run orders"

[0]
[0] > microservices@1.0.0 frontend
[0] > node ./src/frontend/server.js
[0]
[0] Frontend microservice listening on port 8080!
[1]
[1] > microservices@1.0.0 products
[1] > node ./src/products/server.js
[1]
[2]
[2] > microservices@1.0.0 orders
[2] > node ./src/orders/server.js
[2]
[1] Products microservice listening on port 8082!
[2] Orders microservice listening on port 8081!

^C[2] npm run orders exited with code SIGINT
[0] npm run frontend exited with code SIGINT
[1] npm run products exited with code SIGINT

```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud services enable cloudbuild.googleapis.com

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-07eed6bf7f22)$ cd monolith/
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ ls -l
total 60
drwxr-xr-x  2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:46 data
-rw-r--r--  1 student_01_d8f47e91d77f student_01_d8f47e91d77f   965 Sep  2 03:46 Dockerfile
drwxr-xr-x  2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:46 k8s
drwxr-xr-x 52 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:51 node_modules
-rw-r--r--  1 student_01_d8f47e91d77f student_01_d8f47e91d77f   339 Sep  2 03:46 package.json
-rw-r--r--  1 student_01_d8f47e91d77f student_01_d8f47e91d77f 31302 Sep  2 03:51 package-lock.json
drwxr-xr-x  3 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:53 public
drwxr-xr-x  2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:46 src

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/fancytest:1.0.0 .
```
```
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555229.745605-4aa9df3c3d8f4797893855b25bedc594.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-07eed6bf7f22/locations/global/builds/dc3b5572-9462-43ae-8544-d111716464ae].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/dc3b5572-9462-43ae-8544-d111716464ae?project=140263013750].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "dc3b5572-9462-43ae-8544-d111716464ae"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555229.745605-4aa9df3c3d8f4797893855b25bedc594.tgz#1630555231679677
Copying gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555229.745605-4aa9df3c3d8f4797893855b25bedc594.tgz#1630555231679677...
/ [1 files][  1.4 MiB/  1.4 MiB]
Operation completed over 1 objects/1.4 MiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  2.512MB
Step 1/7 : FROM node:10
10: Pulling from library/node
76b8ef87096f: Pulling fs layer
2e2bafe8a0f4: Pulling fs layer
b53ce1fd2746: Pulling fs layer
84a8c1bd5887: Pulling fs layer
7a803dc0b40f: Pulling fs layer
84a8c1bd5887: Waiting
b800e94e7303: Pulling fs layer
0da9fbf60d48: Pulling fs layer
04dccde934cf: Pulling fs layer
7a803dc0b40f: Waiting
b800e94e7303: Waiting
0da9fbf60d48: Waiting
73269890f6fd: Pulling fs layer
04dccde934cf: Waiting
73269890f6fd: Waiting
b53ce1fd2746: Verifying Checksum
b53ce1fd2746: Download complete
2e2bafe8a0f4: Verifying Checksum
2e2bafe8a0f4: Download complete
76b8ef87096f: Verifying Checksum
76b8ef87096f: Download complete
b800e94e7303: Verifying Checksum
b800e94e7303: Download complete
84a8c1bd5887: Download complete
04dccde934cf: Verifying Checksum
04dccde934cf: Download complete
73269890f6fd: Verifying Checksum
73269890f6fd: Download complete
0da9fbf60d48: Verifying Checksum
0da9fbf60d48: Download complete
7a803dc0b40f: Verifying Checksum
7a803dc0b40f: Download complete
76b8ef87096f: Pull complete
2e2bafe8a0f4: Pull complete
b53ce1fd2746: Pull complete
84a8c1bd5887: Pull complete
7a803dc0b40f: Pull complete
b800e94e7303: Pull complete
0da9fbf60d48: Pull complete
04dccde934cf: Pull complete
73269890f6fd: Pull complete
Digest: sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911
Status: Downloaded newer image for node:10
 ---> 28dca6642db8
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in 3ddbb616fc7d
Removing intermediate container 3ddbb616fc7d
 ---> 4ed8b6826bcb
Step 3/7 : COPY package*.json ./
 ---> 3b7f8faeedbe
Step 4/7 : RUN npm install
 ---> Running in a44bc461c52c
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.694s
found 0 vulnerabilities
Removing intermediate container a44bc461c52c
 ---> 449147a39d8f
Step 5/7 : COPY . .
 ---> a5a2ebf6edc2
Step 6/7 : EXPOSE 8080
 ---> Running in 442ad168854b
Removing intermediate container 442ad168854b
 ---> 82c63065996b
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in 00d48dd25aa2
Removing intermediate container 00d48dd25aa2
 ---> 6fb5354797d8
Successfully built 6fb5354797d8
Successfully tagged gcr.io/qwiklabs-gcp-01-07eed6bf7f22/fancytest:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-07eed6bf7f22/fancytest:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-07eed6bf7f22/fancytest]
3372fb460485: Preparing
e4dcd75928af: Preparing
499bcbfeb8dc: Preparing
92f4656275be: Preparing
3ab01e8988bf: Preparing
c98dc9a94132: Preparing
3ffdb7e28503: Preparing
33dd93485756: Preparing
607d71c12b77: Preparing
052174538f53: Preparing
8abfe7e7c816: Preparing
c8b886062a47: Preparing
16fc2e3ca032: Preparing
33dd93485756: Waiting
607d71c12b77: Waiting
052174538f53: Waiting
8abfe7e7c816: Waiting
c8b886062a47: Waiting
16fc2e3ca032: Waiting
c98dc9a94132: Waiting
3ffdb7e28503: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
92f4656275be: Pushed
607d71c12b77: Layer already exists
499bcbfeb8dc: Pushed
e4dcd75928af: Pushed
8abfe7e7c816: Layer already exists
052174538f53: Layer already exists
3372fb460485: Pushed
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
1.0.0: digest: sha256:81371ab65a4e0ed34290e443bf1827fdd9611ceaafee3a860b78d2a8028c7bb6 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                               STATUS
dc3b5572-9462-43ae-8544-d111716464ae  2021-09-02T04:00:32+00:00  41S       gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555229.745605-4aa9df3c3d8f4797893855b25bedc594.tgz  gcr.io/qwiklabs-gcp-01-07eed6bf7f22/fancytest:1.0.0  SUCCESS

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud services enable container.googleapis.com

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud container clusters create fancy-cluster --num-nodes 3 --zone us-central1-a --machine-type n1-standard-1

```
```
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster fancy-cluster in us-central1-a...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-07eed6bf7f22/zones/us-central1-a/clusters/fancy-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/fancy-cluster?project=qwiklabs-gcp-01-07eed6bf7f22
kubeconfig entry generated for fancy-cluster.
```
```
NAME           LOCATION       MASTER_VERSION  MASTER_IP      MACHINE_TYPE   NODE_VERSION    NUM_NODES  STATUS
fancy-cluster  us-central1-a  1.20.8-gke.900  34.71.192.198  n1-standard-1  1.20.8-gke.900  3          RUNNING
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl create deployment fancytest --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/fancytest:1.0.0
deployment.apps/fancytest created

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get all
NAME                             READY   STATUS    RESTARTS   AGE
pod/fancytest-59c84d5f6d-4mt9h   1/1     Running   0          46s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.19.240.1   <none>        443/TCP   3m39s

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/fancytest   1/1     1            1           46s

NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/fancytest-59c84d5f6d   1         1         1       46s

```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl expose deployment fancytest --name=fancytest --type=LoadBalancer --port=80 --target-port=8080
service/fancytest exposed

```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get svc
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
fancytest    LoadBalancer   10.19.245.94   34.133.28.63   80:31691/TCP   64s
kubernetes   ClusterIP      10.19.240.1    <none>         443/TCP        4m51s

```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-07eed6bf7f22)$ cd ~/monolith-to-microservices/microservices/src/orders
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ ls -l
total 36
drwxr-xr-x 2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:46 data
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f   961 Sep  2 03:46 Dockerfile
drwxr-xr-x 2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  2 03:46 k8s
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f   324 Sep  2 03:46 package.json
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 14796 Sep  2 03:46 package-lock.json
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f  1096 Sep  2 03:46 server.js
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/orders:1.0.0 .

```
```
Creating temporary tarball archive of 8 file(s) totalling 18.0 KiB before compression.
Some files were not included in the source upload.

Check the gcloud log [/tmp/tmp.VoNnKXMiCm/logs/2021.09.02/04.11.18.081758.log] to see which files and the contents of the
default gcloudignore file used (see `$ gcloud topic gcloudignore` to learn
more).

Uploading tarball of [.] to [gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555878.18881-25972385c25b44f093641b5c6360555c.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-07eed6bf7f22/locations/global/builds/a0a631fc-7960-41fc-af9d-15950bc0a12a].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/a0a631fc-7960-41fc-af9d-15950bc0a12a?project=140263013750].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "a0a631fc-7960-41fc-af9d-15950bc0a12a"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555878.18881-25972385c25b44f093641b5c6360555c.tgz#1630555878762669
Copying gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555878.18881-25972385c25b44f093641b5c6360555c.tgz#1630555878762669...
/ [1 files][  6.2 KiB/  6.2 KiB]
Operation completed over 1 objects/6.2 KiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  26.62kB
Step 1/7 : FROM node:10
10: Pulling from library/node
76b8ef87096f: Pulling fs layer
2e2bafe8a0f4: Pulling fs layer
b53ce1fd2746: Pulling fs layer
84a8c1bd5887: Pulling fs layer
7a803dc0b40f: Pulling fs layer
b800e94e7303: Pulling fs layer
0da9fbf60d48: Pulling fs layer
04dccde934cf: Pulling fs layer
73269890f6fd: Pulling fs layer
b800e94e7303: Waiting
0da9fbf60d48: Waiting
04dccde934cf: Waiting
73269890f6fd: Waiting
84a8c1bd5887: Waiting
7a803dc0b40f: Waiting
b53ce1fd2746: Verifying Checksum
b53ce1fd2746: Download complete
2e2bafe8a0f4: Verifying Checksum
2e2bafe8a0f4: Download complete
84a8c1bd5887: Verifying Checksum
84a8c1bd5887: Download complete
76b8ef87096f: Verifying Checksum
76b8ef87096f: Download complete
b800e94e7303: Download complete
04dccde934cf: Verifying Checksum
04dccde934cf: Download complete
73269890f6fd: Verifying Checksum
73269890f6fd: Download complete
0da9fbf60d48: Verifying Checksum
0da9fbf60d48: Download complete
7a803dc0b40f: Verifying Checksum
7a803dc0b40f: Download complete
76b8ef87096f: Pull complete
2e2bafe8a0f4: Pull complete
b53ce1fd2746: Pull complete
84a8c1bd5887: Pull complete
7a803dc0b40f: Pull complete
b800e94e7303: Pull complete
0da9fbf60d48: Pull complete
04dccde934cf: Pull complete
73269890f6fd: Pull complete
Digest: sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911
Status: Downloaded newer image for node:10
 ---> 28dca6642db8
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in a4afefc86ff4
Removing intermediate container a4afefc86ff4
 ---> 48ed8fe6309b
Step 3/7 : COPY package*.json ./
 ---> 7345862f4af5
Step 4/7 : RUN npm install
 ---> Running in bb2cd686bfb9
npm WARN orders@1.0.0 No description
npm WARN orders@1.0.0 No repository field.

added 52 packages from 39 contributors and audited 52 packages in 1.884s
found 0 vulnerabilities
Removing intermediate container bb2cd686bfb9
 ---> e90fa39e29c6
Step 5/7 : COPY . .
 ---> 46476cf48633
Step 6/7 : EXPOSE 8081
 ---> Running in 64bd324e0a6e
Removing intermediate container 64bd324e0a6e
 ---> f29c9dd3cf52
Step 7/7 : CMD [ "node", "server.js" ]
 ---> Running in 18bc951bfbf2
Removing intermediate container 18bc951bfbf2
 ---> a10d383a111c
Successfully built a10d383a111c
Successfully tagged gcr.io/qwiklabs-gcp-01-07eed6bf7f22/orders:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-07eed6bf7f22/orders:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-07eed6bf7f22/orders]
bba006c5cb0f: Preparing
640f5bb7f197: Preparing
124ca7292450: Preparing
9afcb4ae9ad8: Preparing
3ab01e8988bf: Preparing
c98dc9a94132: Preparing
3ffdb7e28503: Preparing
33dd93485756: Preparing
607d71c12b77: Preparing
052174538f53: Preparing
8abfe7e7c816: Preparing
c8b886062a47: Preparing
16fc2e3ca032: Preparing
c98dc9a94132: Waiting
3ffdb7e28503: Waiting
33dd93485756: Waiting
607d71c12b77: Waiting
052174538f53: Waiting
8abfe7e7c816: Waiting
c8b886062a47: Waiting
16fc2e3ca032: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
607d71c12b77: Layer already exists
052174538f53: Layer already exists
8abfe7e7c816: Layer already exists
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
9afcb4ae9ad8: Pushed
bba006c5cb0f: Pushed
640f5bb7f197: Pushed
124ca7292450: Pushed
1.0.0: digest: sha256:3174d28481f882e6ffcd60a949589effc406692187f2d56a4e88fd7b94b8db2c size: 3049
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                     IMAGES                                            STATUS
a0a631fc-7960-41fc-af9d-15950bc0a12a  2021-09-02T04:11:19+00:00  44S       gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555878.18881-25972385c25b44f093641b5c6360555c.tgz  gcr.io/qwiklabs-gcp-01-07eed6bf7f22/orders:1.0.0  SUCCESS


```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ cd ~/monolith-to-microservices/microservices/src/products
```

```

student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/products:1.0.0 .

```
```
Creating temporary tarball archive of 8 file(s) totalling 20.2 KiB before compression.
Some files were not included in the source upload.

Check the gcloud log [/tmp/tmp.VoNnKXMiCm/logs/2021.09.02/04.12.51.137377.log] to see which files and the contents of the
default gcloudignore file used (see `$ gcloud topic gcloudignore` to learn
more).

Uploading tarball of [.] to [gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555971.22912-6df80bf24c454c3a9163678785039a7d.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-07eed6bf7f22/locations/global/builds/92256fc5-a988-4528-b9c1-62b4511f28fa].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/92256fc5-a988-4528-b9c1-62b4511f28fa?project=140263013750].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "92256fc5-a988-4528-b9c1-62b4511f28fa"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555971.22912-6df80bf24c454c3a9163678785039a7d.tgz#1630555971793496
Copying gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555971.22912-6df80bf24c454c3a9163678785039a7d.tgz#1630555971793496...
/ [1 files][  6.8 KiB/  6.8 KiB]
Operation completed over 1 objects/6.8 KiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  28.67kB
Step 1/7 : FROM node:10
10: Pulling from library/node
76b8ef87096f: Pulling fs layer
2e2bafe8a0f4: Pulling fs layer
b53ce1fd2746: Pulling fs layer
84a8c1bd5887: Pulling fs layer
7a803dc0b40f: Pulling fs layer
b800e94e7303: Pulling fs layer
0da9fbf60d48: Pulling fs layer
04dccde934cf: Pulling fs layer
73269890f6fd: Pulling fs layer
b800e94e7303: Waiting
0da9fbf60d48: Waiting
84a8c1bd5887: Waiting
7a803dc0b40f: Waiting
04dccde934cf: Waiting
73269890f6fd: Waiting
b53ce1fd2746: Verifying Checksum
b53ce1fd2746: Download complete
2e2bafe8a0f4: Download complete
76b8ef87096f: Verifying Checksum
76b8ef87096f: Download complete
84a8c1bd5887: Verifying Checksum
84a8c1bd5887: Download complete
b800e94e7303: Verifying Checksum
b800e94e7303: Download complete
04dccde934cf: Verifying Checksum
04dccde934cf: Download complete
73269890f6fd: Verifying Checksum
73269890f6fd: Download complete
0da9fbf60d48: Verifying Checksum
0da9fbf60d48: Download complete
7a803dc0b40f: Verifying Checksum
7a803dc0b40f: Download complete
76b8ef87096f: Pull complete
2e2bafe8a0f4: Pull complete
b53ce1fd2746: Pull complete
84a8c1bd5887: Pull complete
7a803dc0b40f: Pull complete
b800e94e7303: Pull complete
0da9fbf60d48: Pull complete
04dccde934cf: Pull complete
73269890f6fd: Pull complete
Digest: sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911
Status: Downloaded newer image for node:10
 ---> 28dca6642db8
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in 415def19e333
Removing intermediate container 415def19e333
 ---> 58b9db1435fe
Step 3/7 : COPY package*.json ./
 ---> b4aef93494c9
Step 4/7 : RUN npm install
 ---> Running in ae1336f2a28a
npm WARN products@1.0.0 No description
npm WARN products@1.0.0 No repository field.

added 52 packages from 39 contributors and audited 52 packages in 2.095s
found 0 vulnerabilities
Removing intermediate container ae1336f2a28a
 ---> c3d5a5969be4
Step 5/7 : COPY . .
 ---> 1f3301c8da6a
Step 6/7 : EXPOSE 8082
 ---> Running in ea5cd1caab53
Removing intermediate container ea5cd1caab53
 ---> a253722ebc46
Step 7/7 : CMD [ "node", "server.js" ]
 ---> Running in 192078ab5c16
Removing intermediate container 192078ab5c16
 ---> e53ba8dc63b1
Successfully built e53ba8dc63b1
Successfully tagged gcr.io/qwiklabs-gcp-01-07eed6bf7f22/products:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-07eed6bf7f22/products:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-07eed6bf7f22/products]
fbbc88b9df95: Preparing
88bdbd8db9b5: Preparing
5fd9686d629e: Preparing
1c9d0ef4ee30: Preparing
3ab01e8988bf: Preparing
c98dc9a94132: Preparing
3ffdb7e28503: Preparing
33dd93485756: Preparing
607d71c12b77: Preparing
052174538f53: Preparing
8abfe7e7c816: Preparing
c8b886062a47: Preparing
16fc2e3ca032: Preparing
33dd93485756: Waiting
607d71c12b77: Waiting
052174538f53: Waiting
8abfe7e7c816: Waiting
c8b886062a47: Waiting
16fc2e3ca032: Waiting
c98dc9a94132: Waiting
3ffdb7e28503: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
607d71c12b77: Layer already exists
052174538f53: Layer already exists
8abfe7e7c816: Layer already exists
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
1c9d0ef4ee30: Pushed
fbbc88b9df95: Pushed
5fd9686d629e: Pushed
88bdbd8db9b5: Pushed
1.0.0: digest: sha256:ba15679f46f49878b09713abde7b4254a316577b71a428e1f94a057f8d0ea8d9 size: 3049
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                     IMAGES                                              STATUS
92256fc5-a988-4528-b9c1-62b4511f28fa  2021-09-02T04:12:52+00:00  38S       gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630555971.22912-6df80bf24c454c3a9163678785039a7d.tgz  gcr.io/qwiklabs-gcp-01-07eed6bf7f22/products:1.0.0  SUCCESS

```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ cd ~/monolith-to-microservices/microservices/src/orders

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl create deployment orders --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/orders:1.0.0
deployment.apps/orders created

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
fancytest-59c84d5f6d-4mt9h   1/1     Running   0          7m24s
orders-bcfcc9864-rnt8m       1/1     Running   0          24s

```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl expose deployment orders --type=LoadBalancer --port 80 --target-port 8081
service/orders exposed
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)        AGE
fancytest    LoadBalancer   10.19.245.94    34.133.28.63   80:31691/TCP   6m40s
kubernetes   ClusterIP      10.19.240.1     <none>         443/TCP        10m
orders       LoadBalancer   10.19.240.151   <pending>      80:32567/TCP   6s
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-07eed6bf7f22)$ cd ~/monolith-to-microservices/microservices/src/products
```


```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl create deployment products --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/products:1.0.0

```

```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
fancytest-59c84d5f6d-4mt9h   1/1     Running   0          8m35s
orders-bcfcc9864-rnt8m       1/1     Running   0          95s
products-856b6688c7-fmf2z    1/1     Running   0          30s
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl expose deployment products --type=LoadBalancer --port 80 --target-port 8082
service/products exposed
  
```
```

student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
fancytest    LoadBalancer   10.19.245.94    34.133.28.63     80:31691/TCP   8m50s
kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        12m
orders       LoadBalancer   10.19.240.151   35.222.210.176   80:32567/TCP   2m16s
products     LoadBalancer   10.19.249.165   34.72.26.15      80:31109/TCP   64s
 
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-07eed6bf7f22)$ cd ~/monolith-to-microservices/react-app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ nano .env
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ cat .env
REACT_APP_ORDERS_URL=http://localhost:8081/api/orders
REACT_APP_PRODUCTS_URL=http://localhost:8082/api/productsstudent_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ nano .env                                                                                                                                                     
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ nano .env
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ cat .env
REACT_APP_ORDERS_URL=http://35.222.210.176:8081/api/orders
REACT_APP_PRODUCTS_URL=http://34.72.26.15:8082/api/products
  
```
  
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ ls -l
total 1292
drwxr-xr-x    3 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:53 build
drwxr-xr-x 1051 student_01_d8f47e91d77f student_01_d8f47e91d77f   36864 Sep  2 03:52 node_modules
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f    1094 Sep  2 03:46 package.json
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1253546 Sep  2 03:52 package-lock.json
drwxr-xr-x    3 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 public
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f    2881 Sep  2 03:46 README.md
drwxr-xr-x    2 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 scripts
drwxr-xr-x    4 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 src
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ ls -la
total 1312
drwxr-xr-x    7 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 04:19 .
drwxr-xr-x    7 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 ..
drwxr-xr-x    3 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:53 build
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f     119 Sep  2 04:19 .env
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f      77 Sep  2 03:46 .env.monolith
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f     299 Sep  2 03:46 .gitignore
drwxr-xr-x 1051 student_01_d8f47e91d77f student_01_d8f47e91d77f   36864 Sep  2 03:52 node_modules
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f    1094 Sep  2 03:46 package.json
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1253546 Sep  2 03:52 package-lock.json
drwxr-xr-x    3 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 public
-rw-r--r--    1 student_01_d8f47e91d77f student_01_d8f47e91d77f    2881 Sep  2 03:46 README.md
drwxr-xr-x    2 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 scripts
drwxr-xr-x    4 student_01_d8f47e91d77f student_01_d8f47e91d77f    4096 Sep  2 03:46 src
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ npm run build
```
  
```  
> frontend@0.1.0 prebuild
> npm run build:monolith


> frontend@0.1.0 build:monolith
> env-cmd -f .env.monolith react-scripts build

Creating an optimized production build...
Compiled successfully.

File sizes after gzip:

  79.08 KB         build/static/js/2.99058a84.chunk.js
  1.99 KB (-19 B)  build/static/js/main.c4e7aaac.chunk.js
  770 B            build/static/js/runtime-main.c8a21426.js

The project was built assuming it is hosted at /.
You can control this with the homepage field in your package.json.

The build folder is ready to be deployed.
You may serve it with a static server:

  npm install -g serve
  serve -s build

Find out more about deployment here:

  bit.ly/CRA-deploy


> frontend@0.1.0 postbuild:monolith
> node scripts/post-build.js ./build ../monolith/public

Deleting stale folder: ../monolith/public
Deleted stale destination folder: ../monolith/public
Copying files from ./build to ../monolith/public
Copied ./build to ../monolith/public successfully!

> frontend@0.1.0 build
> react-scripts build

Creating an optimized production build...
Compiled successfully.

File sizes after gzip:

  79.08 KB         build/static/js/2.99058a84.chunk.js
  2.03 KB (+34 B)  build/static/js/main.541b448e.chunk.js
  770 B            build/static/js/runtime-main.c8a21426.js

The project was built assuming it is hosted at /.
You can control this with the homepage field in your package.json.

The build folder is ready to be deployed.
You may serve it with a static server:

  npm install -g serve
  serve -s build

Find out more about deployment here:

  bit.ly/CRA-deploy


> frontend@0.1.0 postbuild
> node scripts/post-build.js ./build ../microservices/src/frontend/public

Deleting stale folder: ../microservices/src/frontend/public
Deleted stale destination folder: ../microservices/src/frontend/public
Copying files from ./build to ../microservices/src/frontend/public
Copied ./build to ../microservices/src/frontend/public successfully!
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-07eed6bf7f22)$ cd ~/monolith-to-microservices/microservices/src/frontend
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/frontend:1.0.0 .
Creating temporary tarball archive of 31 file(s) totalling 2.3 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630556502.831855-44b0945739154eed88c2a845f556d218.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-07eed6bf7f22/locations/global/builds/00fc3856-f786-422e-a9fa-8f0dd9c44f9c].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/00fc3856-f786-422e-a9fa-8f0dd9c44f9c?project=140263013750].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "00fc3856-f786-422e-a9fa-8f0dd9c44f9c"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630556502.831855-44b0945739154eed88c2a845f556d218.tgz#1630556504005573
Copying gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630556502.831855-44b0945739154eed88c2a845f556d218.tgz#1630556504005573...
/ [1 files][  1.4 MiB/  1.4 MiB]
Operation completed over 1 objects/1.4 MiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  2.488MB
Step 1/7 : FROM node:10
10: Pulling from library/node
76b8ef87096f: Pulling fs layer
2e2bafe8a0f4: Pulling fs layer
b53ce1fd2746: Pulling fs layer
84a8c1bd5887: Pulling fs layer
7a803dc0b40f: Pulling fs layer
b800e94e7303: Pulling fs layer
0da9fbf60d48: Pulling fs layer
04dccde934cf: Pulling fs layer
73269890f6fd: Pulling fs layer
84a8c1bd5887: Waiting
7a803dc0b40f: Waiting
b800e94e7303: Waiting
0da9fbf60d48: Waiting
04dccde934cf: Waiting
73269890f6fd: Waiting
b53ce1fd2746: Verifying Checksum
b53ce1fd2746: Download complete
2e2bafe8a0f4: Verifying Checksum
2e2bafe8a0f4: Download complete
76b8ef87096f: Verifying Checksum
76b8ef87096f: Download complete
84a8c1bd5887: Verifying Checksum
84a8c1bd5887: Download complete
b800e94e7303: Verifying Checksum
b800e94e7303: Download complete
04dccde934cf: Verifying Checksum
04dccde934cf: Download complete
73269890f6fd: Verifying Checksum
73269890f6fd: Download complete
0da9fbf60d48: Verifying Checksum
0da9fbf60d48: Download complete
7a803dc0b40f: Verifying Checksum
7a803dc0b40f: Download complete
76b8ef87096f: Pull complete
2e2bafe8a0f4: Pull complete
b53ce1fd2746: Pull complete
84a8c1bd5887: Pull complete
7a803dc0b40f: Pull complete
b800e94e7303: Pull complete
0da9fbf60d48: Pull complete
04dccde934cf: Pull complete
73269890f6fd: Pull complete
Digest: sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911
Status: Downloaded newer image for node:10
 ---> 28dca6642db8
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in b3face7fb9be
Removing intermediate container b3face7fb9be
 ---> 197c4c00672d
Step 3/7 : COPY package*.json ./
 ---> f74a4b5ed097
Step 4/7 : RUN npm install
 ---> Running in 489dc94bd9bf
npm WARN frontend@1.0.0 No description
npm WARN frontend@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.509s
found 0 vulnerabilities
Removing intermediate container 489dc94bd9bf
 ---> 823db6dd294d
Step 5/7 : COPY . .
 ---> ce5516a8f32f
Step 6/7 : EXPOSE 8080
 ---> Running in ea147f2523ab
Removing intermediate container ea147f2523ab
 ---> e2c5475dcd35
Step 7/7 : CMD [ "node", "server.js" ]
 ---> Running in a1527506c39e
Removing intermediate container a1527506c39e
 ---> 32eb8bfc9e0a
Successfully built 32eb8bfc9e0a
Successfully tagged gcr.io/qwiklabs-gcp-01-07eed6bf7f22/frontend:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-07eed6bf7f22/frontend:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-07eed6bf7f22/frontend]
7ad83d8e453a: Preparing
1d9c6c226e66: Preparing
c285c6662951: Preparing
e5aa7264d8a8: Preparing
3ab01e8988bf: Preparing
c98dc9a94132: Preparing
3ffdb7e28503: Preparing
33dd93485756: Preparing
607d71c12b77: Preparing
052174538f53: Preparing
8abfe7e7c816: Preparing
c8b886062a47: Preparing
16fc2e3ca032: Preparing
33dd93485756: Waiting
607d71c12b77: Waiting
052174538f53: Waiting
8abfe7e7c816: Waiting
c8b886062a47: Waiting
16fc2e3ca032: Waiting
c98dc9a94132: Waiting
3ffdb7e28503: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
607d71c12b77: Layer already exists
052174538f53: Layer already exists
8abfe7e7c816: Layer already exists
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
e5aa7264d8a8: Pushed
c285c6662951: Pushed
1d9c6c226e66: Pushed
7ad83d8e453a: Pushed
1.0.0: digest: sha256:58e5b43b03ca2689bf9d8a47bdf66ca51f927f6e3cabbcb6de3bff9e78512d0d size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
00fc3856-f786-422e-a9fa-8f0dd9c44f9c  2021-09-02T04:21:44+00:00  40S       gs://qwiklabs-gcp-01-07eed6bf7f22_cloudbuild/source/1630556502.831855-44b0945739154eed88c2a845f556d218.tgz  gcr.io/qwiklabs-gcp-01-07eed6bf7f22/frontend:1.0.0  SUCCESS
```
  
```  
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl create deployment frontend --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/frontend:1.0.0
deployment.apps/frontend created
  
```
  
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
fancytest-59c84d5f6d-4mt9h   1/1     Running   0          14m
frontend-7987685d57-mf572    1/1     Running   0          7s
orders-bcfcc9864-rnt8m       1/1     Running   0          7m57s
products-856b6688c7-fmf2z    1/1     Running   0          6m52s
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl expose deployment frontend --type=LoadBalancer --port 80 --target-port 8080
service/frontend exposed
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
fancytest    LoadBalancer   10.19.245.94    34.133.28.63     80:31691/TCP   15m
frontend     LoadBalancer   10.19.240.91    34.136.230.137   80:30179/TCP   47s
kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        18m
orders       LoadBalancer   10.19.240.151   35.222.210.176   80:32567/TCP   8m32s
products     LoadBalancer   10.19.249.165   34.72.26.15      80:31109/TCP   7m20s
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl delete deployment fancytest
deployment.apps "fancytest" deleted
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl delete svc fancytest
service "fancytest" deleted
  
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-07eed6bf7f22)$ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/frontend-7987685d57-mf572   1/1     Running   0          3m2s
pod/orders-bcfcc9864-rnt8m      1/1     Running   0          10m
pod/products-856b6688c7-fmf2z   1/1     Running   0          9m47s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
service/frontend     LoadBalancer   10.19.240.91    34.136.230.137   80:30179/TCP   2m39s
service/kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        20m
service/orders       LoadBalancer   10.19.240.151   35.222.210.176   80:32567/TCP   10m
service/products     LoadBalancer   10.19.249.165   34.72.26.15      80:31109/TCP   9m12s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/frontend   1/1     1            1           3m3s
deployment.apps/orders     1/1     1            1           10m
deployment.apps/products   1/1     1            1           9m48s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/frontend-7987685d57   1         1         1       3m3s
replicaset.apps/orders-bcfcc9864      1         1         1       10m
replicaset.apps/products-856b6688c7   1         1         1       9m48s

```
