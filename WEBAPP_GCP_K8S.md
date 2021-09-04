Welcome to Cloud Shell! Type "help" to get started.
Your Cloud Platform project in this session is set to qwiklabs-gcp-01-99ac96e9c528.
Use “gcloud config set project [PROJECT_ID]” to change to a different project.
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud auth list
           Credentialed Accounts
ACTIVE  ACCOUNT
*       student-01-d8f47e91d77f@qwiklabs.net

To set the active account, run:
    $ gcloud config set account `ACCOUNT`
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud config set compute/zone us-central1-f
```
Updated property [compute/zone].

```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud services enable container.googleapis.com
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud container clusters create fancy-cluster --num-nodes 3
```
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster fancy-cluster in us-central1-f...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-99ac96e9c528/zones/us-central1-f/clusters/fancy-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-f/fancy-cluster?project=qwiklabs-gcp-01-99ac96e9c528
kubeconfig entry generated for fancy-cluster.
```
NAME           LOCATION       MASTER_VERSION   MASTER_IP     MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
fancy-cluster  us-central1-f  1.20.8-gke.2100  34.67.79.206  e2-medium     1.20.8-gke.2100  3          RUNNING
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud compute instances list
```
```
NAME                                          ZONE           MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP   STATUS
gke-fancy-cluster-default-pool-0916f968-h1n0  us-central1-f  e2-medium                  10.128.0.2   34.122.68.2   RUNNING
gke-fancy-cluster-default-pool-0916f968-l2h2  us-central1-f  e2-medium                  10.128.0.3   34.123.3.249  RUNNING
gke-fancy-cluster-default-pool-0916f968-vdq8  us-central1-f  e2-medium                  10.128.0.4   34.133.86.57  RUNNING
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ cd ~
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ git clone https://github.com/googlecodelabs/monolith-to-microservices.git
```
Cloning into 'monolith-to-microservices'...
remote: Enumerating objects: 988, done.
remote: Counting objects: 100% (52/52), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 988 (delta 39), reused 0 (delta 0), pack-reused 936
Receiving objects: 100% (988/988), 2.82 MiB | 12.65 MiB/s, done.
Resolving deltas: 100% (440/440), done.
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ cd ~/monolith-to-microservices
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-99ac96e9c528)$ ./setup.sh
```
Checking for required npm version...Completed.
Installing monolith dependencies...Completed.
Installing microservies dependencies...Completed.
Installing React app dependencies...Completed.
Building React app and placing into sub projects...Completed.

Script completed successfully!
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-01-99ac96e9c528)$ cd ~/monolith-to-microservices/monolith
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ npm start
```
> monolith@1.0.0 start
> node ./src/server.js

Monolith listening on port 8080!

^C
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ gcloud services enable cloudbuild.googleapis.com
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ cd ~/monolith-to-microservices/monolith
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ ls -l
```
total 60
drwxr-xr-x  2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  1 18:42 data
-rw-r--r--  1 student_01_d8f47e91d77f student_01_d8f47e91d77f   965 Sep  1 18:42 Dockerfile
drwxr-xr-x  2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  1 18:42 k8s
drwxr-xr-x 52 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  1 18:42 node_modules
-rw-r--r--  1 student_01_d8f47e91d77f student_01_d8f47e91d77f   339 Sep  1 18:42 package.json
-rw-r--r--  1 student_01_d8f47e91d77f student_01_d8f47e91d77f 31302 Sep  1 18:42 package-lock.json
drwxr-xr-x  3 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  1 18:44 public
drwxr-xr-x  2 student_01_d8f47e91d77f student_01_d8f47e91d77f  4096 Sep  1 18:42 src
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 .
```
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522055.224441-49547fb3e3ee4198a1df4d0acebb414e.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-99ac96e9c528/locations/global/builds/529de535-f056-4980-9b98-c84420ea51af].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/529de535-f056-4980-9b98-c84420ea51af?project=1085943362027].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "529de535-f056-4980-9b98-c84420ea51af"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522055.224441-49547fb3e3ee4198a1df4d0acebb414e.tgz#1630522057087425
Copying gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522055.224441-49547fb3e3ee4198a1df4d0acebb414e.tgz#1630522057087425...
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
b800e94e7303: Verifying Checksum
b800e94e7303: Download complete
84a8c1bd5887: Verifying Checksum
84a8c1bd5887: Download complete
0da9fbf60d48: Verifying Checksum
0da9fbf60d48: Download complete
04dccde934cf: Verifying Checksum
04dccde934cf: Download complete
73269890f6fd: Verifying Checksum
73269890f6fd: Download complete
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
 ---> Running in e4b68ebfab77
Removing intermediate container e4b68ebfab77
 ---> 96eef2beaa5b
Step 3/7 : COPY package*.json ./
 ---> d705a1ceeaae
Step 4/7 : RUN npm install
 ---> Running in 685938262d7d
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.608s
found 0 vulnerabilities

Removing intermediate container 685938262d7d
 ---> 07288b603862
Step 5/7 : COPY . .
 ---> 4498ccaf9b2c
Step 6/7 : EXPOSE 8080
 ---> Running in 8157d7a1aa25
Removing intermediate container 8157d7a1aa25
 ---> 59afa39b5c18
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in 7446b4dd1520
Removing intermediate container 7446b4dd1520
 ---> 2960a28af77c
Successfully built 2960a28af77c
Successfully tagged gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith]
f333a0bbec4e: Preparing
d18d0ea8c12d: Preparing
f7b19deeef84: Preparing
1aeb4b6536f0: Preparing
3ab01e8988bf: Preparing
c98dc9a94132: Preparing
3ffdb7e28503: Preparing
33dd93485756: Preparing
607d71c12b77: Preparing
052174538f53: Preparing
8abfe7e7c816: Preparing
c8b886062a47: Preparing
16fc2e3ca032: Preparing
607d71c12b77: Waiting
052174538f53: Waiting
c98dc9a94132: Waiting
3ffdb7e28503: Waiting
33dd93485756: Waiting
8abfe7e7c816: Waiting
c8b886062a47: Waiting
16fc2e3ca032: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
607d71c12b77: Layer already exists
f7b19deeef84: Pushed
1aeb4b6536f0: Pushed
052174538f53: Layer already exists
d18d0ea8c12d: Pushed
f333a0bbec4e: Pushed
8abfe7e7c816: Layer already exists
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
1.0.0: digest: sha256:10d5b4bf3f458429a8cd1cabb29248096b1b7df77e6bdea372e5d0c353009e42 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
529de535-f056-4980-9b98-c84420ea51af  2021-09-01T18:47:37+00:00  41S       gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522055.224441-49547fb3e3ee4198a1df4d0acebb414e.tgz  gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:1.0.0  SUCCESS
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl create deployment monolith --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0
```
deployment.apps/monolith created
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get deployment
```
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
monolith   0/1     1            0           17s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get pods
```
NAME                        READY   STATUS    RESTARTS   AGE
monolith-5d5cfddf98-b8pgz   1/1     Running   0          27s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get deployment
```
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
monolith   1/1     1            1           30s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get all
```
```
NAME                            READY   STATUS    RESTARTS   AGE
pod/monolith-5d5cfddf98-b8pgz   1/1     Running   0          44s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.19.240.1   <none>        443/TCP   10m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           44s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-5d5cfddf98   1         1         1       44s
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl expose deployment monolith --type=LoadBalancer --port 80 --target-port 8080
service/monolith exposed
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get service
NAME         TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
kubernetes   ClusterIP      10.19.240.1    <none>          443/TCP        12m
monolith     LoadBalancer   10.19.250.21   35.188.77.160   80:32719/TCP   41s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl scale deployment monolith --replicas=3
deployment.apps/monolith scaled
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get all
```
NAME                            READY   STATUS              RESTARTS   AGE
pod/monolith-5d5cfddf98-b8pgz   1/1     Running             0          4m26s
pod/monolith-5d5cfddf98-ddj2j   1/1     Running             0          8s
pod/monolith-5d5cfddf98-nssdd   0/1     ContainerCreating   0          8s

NAME                 TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1    <none>          443/TCP        14m
service/monolith     LoadBalancer   10.19.250.21   35.188.77.160   80:32719/TCP   2m32s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   2/3     3            2           4m27s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-5d5cfddf98   3         3         2       4m27s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ cd ~/monolith-to-microservices/react-app/src/pages/Home
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app/src/pages/Home (qwiklabs-gcp-01-99ac96e9c528)$ mv index.js.new index.js
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app/src/pages/Home (qwiklabs-gcp-01-99ac96e9c528)$ cat ~/monolith-to-microservices/react-app/src/pages/Home/index.js
```
```
/*
Copyright 2019 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import Typography from "@material-ui/core/Typography";
const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1
  },
  paper: {
    width: "800px",
    margin: "0 auto",
    padding: theme.spacing(3, 2)
  }
}));
export default function Home() {
  const classes = useStyles();
  return (
    <div className={classes.root}>
      <Paper className={classes.paper}>
        <Typography variant="h5">
          Fancy Fashion &amp; Style Online
        </Typography>
        <br />
        <Typography variant="body1">
          Tired of mainstream fashion ideas, popular trends and societal norms?
          This line of lifestyle products will help you catch up with the Fancy trend and express your personal style.
          Start shopping Fancy items now!
        </Typography>
      </Paper>
    </div>
  );
}
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app/src/pages/Home (qwiklabs-gcp-01-99ac96e9c528)$ cd ~/monolith-to-microservices/react-apstudent_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-99ac96e9c528)$ npm run build:monolith
```
> frontend@0.1.0 build:monolith
> env-cmd -f .env.monolith react-scripts build

Creating an optimized production build...
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db

Why you should do it regularly:
https://github.com/browserslist/browserslist#browsers-data-updating
Compiled successfully.

File sizes after gzip:

  79.08 KB         build/static/js/2.99058a84.chunk.js
  2.09 KB (+83 B)  build/static/js/main.354d9fb0.chunk.js
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
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-99ac96e9c528)$ cd ~/monolith-to-microservices/monolith
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 .
```
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522568.205373-a791bff0ea1b43cdb50f8bdce8ab5067.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-99ac96e9c528/locations/global/builds/1d3de4c0-40a7-4e51-a9a3-503d812d8121].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/1d3de4c0-40a7-4e51-a9a3-503d812d8121?project=1085943362027].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "1d3de4c0-40a7-4e51-a9a3-503d812d8121"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522568.205373-a791bff0ea1b43cdb50f8bdce8ab5067.tgz#1630522569466836
Copying gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522568.205373-a791bff0ea1b43cdb50f8bdce8ab5067.tgz#1630522569466836...
/ [1 files][  1.4 MiB/  1.4 MiB]
Operation completed over 1 objects/1.4 MiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  2.513MB
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
 ---> Running in 7bd5a7c86bba
Removing intermediate container 7bd5a7c86bba
 ---> 864ae52c631d
Step 3/7 : COPY package*.json ./
 ---> b36162a37eff
Step 4/7 : RUN npm install
 ---> Running in 5433fe0f32a0
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.814s
found 0 vulnerabilities

Removing intermediate container 5433fe0f32a0
 ---> 92c6ccc2e905
Step 5/7 : COPY . .
 ---> f708a580086e
Step 6/7 : EXPOSE 8080
 ---> Running in 388d1cb44faa
Removing intermediate container 388d1cb44faa
 ---> 305cf3c56c0c
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in 10d37b634560
Removing intermediate container 10d37b634560
 ---> de6df560b65f
Successfully built de6df560b65f
Successfully tagged gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith]
10eca1f5fa89: Preparing
d21f97522051: Preparing
c9994de133fa: Preparing
ffb9f7547004: Preparing
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
c8b886062a47: Waiting
8abfe7e7c816: Waiting
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
ffb9f7547004: Pushed
d21f97522051: Pushed
10eca1f5fa89: Pushed
c9994de133fa: Pushed
2.0.0: digest: sha256:1f3224e20bce9b80f928368c43c8104a0e4bdbb201994fef020c372ebd5cf2d3 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
1d3de4c0-40a7-4e51-a9a3-503d812d8121  2021-09-01T18:56:09+00:00  42S       gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522568.205373-a791bff0ea1b43cdb50f8bdce8ab5067.tgz  gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0  SUCCESS
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 .
```
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522631.97647-52da74efc91f43648f6772942dc532d7.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-99ac96e9c528/locations/global/builds/a87ba5bc-2f37-4619-a87d-332b1aa2da8e].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/a87ba5bc-2f37-4619-a87d-332b1aa2da8e?project=1085943362027].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "a87ba5bc-2f37-4619-a87d-332b1aa2da8e"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522631.97647-52da74efc91f43648f6772942dc532d7.tgz#1630522633237102
Copying gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522631.97647-52da74efc91f43648f6772942dc532d7.tgz#1630522633237102...
/ [1 files][  1.4 MiB/  1.4 MiB]
Operation completed over 1 objects/1.4 MiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  2.513MB
Step 1/7 : FROM node:10
10: Pulling from library/node
76b8ef87096f: Pulling fs layer
2e2bafe8a0f4: Pulling fs layer
b53ce1fd2746: Pulling fs layer
84a8c1bd5887: Pulling fs layer
7a803dc0b40f: Pulling fs layer
b800e94e7303: Pulling fs layer
84a8c1bd5887: Waiting
7a803dc0b40f: Waiting
0da9fbf60d48: Pulling fs layer
04dccde934cf: Pulling fs layer
73269890f6fd: Pulling fs layer
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
b800e94e7303: Download complete
84a8c1bd5887: Verifying Checksum
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
 ---> Running in c8f190544828
Removing intermediate container c8f190544828
 ---> becf63b49980
Step 3/7 : COPY package*.json ./
 ---> a30b8e2b0a30
Step 4/7 : RUN npm install
 ---> Running in 4f8ca32b32cc
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.654s
found 0 vulnerabilities
Removing intermediate container 4f8ca32b32cc
 ---> a94dd601faa9
Step 5/7 : COPY . .
 ---> c9f8c7009a6f
Step 6/7 : EXPOSE 8080
 ---> Running in 1c22da6e5bb3
Removing intermediate container 1c22da6e5bb3
 ---> 6e3aa2350193
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in 74babf4ba43a
Removing intermediate container 74babf4ba43a
 ---> 0fe7d8d8a937
Successfully built 0fe7d8d8a937
Successfully tagged gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith]
134763b233bc: Preparing
c908c1fef23d: Preparing
be4cf699a7c2: Preparing
7e4a5c4023f0: Preparing
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
7e4a5c4023f0: Pushed
be4cf699a7c2: Pushed
c908c1fef23d: Pushed
134763b233bc: Pushed
2.0.0: digest: sha256:e63fab5e0a7bb8ed607285f99220cd2524252a6cacac0620033b8ed2a51c516e size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                     IMAGES                                              STATUS
a87ba5bc-2f37-4619-a87d-332b1aa2da8e  2021-09-01T18:57:13+00:00  39S       gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522631.97647-52da74efc91f43648f6772942dc532d7.tgz  gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0  SUCCESS
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl set image deployment/monolith monolith=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0
deployment.apps/monolith image updated
```
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get pods
```
NAME                        READY   STATUS              RESTARTS   AGE
monolith-5d5cfddf98-b8pgz   1/1     Running             0          8m18s
monolith-5d5cfddf98-ddj2j   1/1     Running             0          4m
monolith-5d5cfddf98-nssdd   1/1     Running             0          4m
monolith-67cd5755b7-wk98g   0/1     ContainerCreating   0          9s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ kubectl get pods
```
NAME                        READY   STATUS        RESTARTS   AGE
monolith-5d5cfddf98-b8pgz   1/1     Terminating   0          9m1s
monolith-5d5cfddf98-ddj2j   1/1     Terminating   0          4m43s
monolith-5d5cfddf98-nssdd   1/1     Terminating   0          4m43s
monolith-67cd5755b7-5ctsr   1/1     Running       0          23s
monolith-67cd5755b7-r67td   1/1     Running       0          26s
monolith-67cd5755b7-wk98g   1/1     Running       0          52s
```
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-99ac96e9c528)$ cd ~
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ rm -rf monolith-to-microservices
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ # Delete the container image for version 1.0.0 of the monolith
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud container images delete gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 --quiet
```
Digests:
- gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith@sha256:10d5b4bf3f458429a8cd1cabb29248096b1b7df77e6bdea372e5d0c353009e42

  Associated tags:
 - 1.0.0
Tags:
- gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:1.0.0
Deleted [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:1.0.0].
Deleted [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith@sha256:10d5b4bf3f458429a8cd1cabb29248096b1b7df77e6bdea372e5d0c353009e42].
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ # Delete the container image for version 2.0.0 of the monolith
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud container images delete gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 --quiet
Digests:
- gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith@sha256:e63fab5e0a7bb8ed607285f99220cd2524252a6cacac0620033b8ed2a51c516e
  Associated tags:
 - 2.0.0
Tags:
- gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0
Deleted [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith:2.0.0].
Deleted [gcr.io/qwiklabs-gcp-01-99ac96e9c528/monolith@sha256:e63fab5e0a7bb8ed607285f99220cd2524252a6cacac0620033b8ed2a51c516e].
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ # The following command will take all source archives from all builds and delete them from cloud storage
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ # Run this command to print all sources:
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ # gcloud builds list | awk 'NR > 1 {print $4}'
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud builds list | awk 'NR > 1 {print $4}' | while read line; do gsutil rm $line; done
```
Removing gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522631.97647-52da74efc91f43648f6772942dc532d7.tgz...
/ [1 objects]
Operation completed over 1 objects.
Removing gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522568.205373-a791bff0ea1b43cdb50f8bdce8ab5067.tgz...
/ [1 objects]
Operation completed over 1 objects.
Removing gs://qwiklabs-gcp-01-99ac96e9c528_cloudbuild/source/1630522055.224441-49547fb3e3ee4198a1df4d0acebb414e.tgz...
/ [1 objects]
Operation completed over 1 objects.
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ kubectl delete service monolith
service "monolith" deleted
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ kubectl delete deployment monolith
deployment.apps "monolith" deleted
```
```
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-01-99ac96e9c528)$ gcloud container clusters delete fancy-cluster
The following clusters will be deleted.
```
- [fancy-cluster] in [us-central1-f]

Do you want to continue (Y/n)?  y

Deleting cluster fancy-cluster...⠧  
