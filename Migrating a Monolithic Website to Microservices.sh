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
 ---> Running in fb1befa504dd
Removing intermediate container fb1befa504dd
 ---> 819c65597bc3
Step 3/7 : COPY package*.json ./
 ---> ba148a3ebaf9
Step 4/7 : RUN npm install
 ---> Running in d12dccd19b16
npm WARN orders@1.0.0 No description
npm WARN orders@1.0.0 No repository field.

added 52 packages from 39 contributors and audited 52 packages in 1.596s
found 0 vulnerabilities
Removing intermediate container d12dccd19b16
 ---> 74ed8e788e82
Step 5/7 : COPY . .
 ---> d997752f1ca8
Step 6/7 : EXPOSE 8081
 ---> Running in f486a8fa8aa6
Removing intermediate container f486a8fa8aa6
 ---> 4c6ccf085ee3
Step 7/7 : CMD [ "node", "server.js" ]
 ---> Running in a8d95a2e4e14
Removing intermediate container a8d95a2e4e14
 ---> 62fd25220359
Successfully built 62fd25220359
Successfully tagged gcr.io/qwiklabs-gcp-01-64f200010379/orders:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-64f200010379/orders:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-64f200010379/orders]
42f37ff3d14e: Preparing
09b399e3f419: Preparing
30b2289fe968: Preparing
1c8957e998e0: Preparing
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
30b2289fe968: Pushed
1c8957e998e0: Pushed
42f37ff3d14e: Pushed
09b399e3f419: Pushed
1.0.0: digest: sha256:0d7a9bcc746884ae318efa4c0381e6636937b0682c9407f424ad372d8473c9a7 size: 3049
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                            STATUS
5158f0c6-e407-4149-a0f7-adaab9d1eced  2021-09-01T19:46:52+00:00  41S       gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630525611.583972-fa0e87e3cb17450888ec25331bbef4b3.tgz  gcr.io/qwiklabs-gcp-01-64f200010379/orders:1.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ kubectl create deployment orders --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/orders:1.0.0
deployment.apps/orders created
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/monolith-76f9d9c4b5-sp8jv   1/1     Running   0          2m22s
pod/orders-785878bbf6-zsf8d     1/1     Running   0          9s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1     <none>          443/TCP        6m34s
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213   80:32767/TCP   2m22s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           2m23s
deployment.apps/orders     1/1     1            1           10s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-76f9d9c4b5   1         1         1       2m23s
replicaset.apps/orders-785878bbf6     1         1         1       10s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ kubectl expose deployment orders --type=LoadBalancer --port 80 --target-port 8081
service/orders exposed
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ kubectl get service orders
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
orders   LoadBalancer   10.19.243.41   <pending>     80:32465/TCP   16s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ kubectl get service orders
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
orders   LoadBalancer   10.19.243.41   <pending>     80:32465/TCP   31s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ kubectl get service orders
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
orders   LoadBalancer   10.19.243.41   34.136.6.221   80:32465/TCP   69s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/orders (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/react-appstudent_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ nano .env.monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ nano .env.monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ npm run build:monolith

> frontend@0.1.0 build:monolith
> env-cmd -f .env.monolith react-scripts build

Creating an optimized production build...
Compiled successfully.

File sizes after gzip:

  79.08 KB        build/static/js/2.99058a84.chunk.js
  2.01 KB (+2 B)  build/static/js/main.f24ba9cf.chunk.js
  770 B           build/static/js/runtime-main.c8a21426.js

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
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 .
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630525906.214886-616f3742d3f1419fb22f6ce994b18219.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-64f200010379/locations/global/builds/74353e51-691b-4be4-b395-2f651c5e3cc7].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/74353e51-691b-4be4-b395-2f651c5e3cc7?project=452830728646].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "74353e51-691b-4be4-b395-2f651c5e3cc7"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630525906.214886-616f3742d3f1419fb22f6ce994b18219.tgz#1630525907289592
Copying gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630525906.214886-616f3742d3f1419fb22f6ce994b18219.tgz#1630525907289592...
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
 ---> Running in 6ab8f383d9e7
Removing intermediate container 6ab8f383d9e7
 ---> e5de8e31c8c1
Step 3/7 : COPY package*.json ./
 ---> 2d19e52eea87
Step 4/7 : RUN npm install
 ---> Running in e5d1ddb528cc
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.695s
found 0 vulnerabilities
Removing intermediate container e5d1ddb528cc
 ---> 85a8f0b04916
Step 5/7 : COPY . .
 ---> 958e8f25a282
Step 6/7 : EXPOSE 8080
 ---> Running in 610f72068dd7
Removing intermediate container 610f72068dd7
 ---> 3396cbad051c
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in b4cd92e56300
Removing intermediate container b4cd92e56300
 ---> 371a5cf95df5
Successfully built 371a5cf95df5
Successfully tagged gcr.io/qwiklabs-gcp-01-64f200010379/monolith:2.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-64f200010379/monolith:2.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-64f200010379/monolith]
552a814b64f2: Preparing
b26e0b36b7b5: Preparing
7e5e73939e29: Preparing
a7da03a6e9ee: Preparing
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
a7da03a6e9ee: Pushed
7e5e73939e29: Pushed
552a814b64f2: Pushed
b26e0b36b7b5: Pushed
2.0.0: digest: sha256:3193962d1dfe5cc7cff12db48a627856e82dea81cd32813a69deb0da292ab172 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
74353e51-691b-4be4-b395-2f651c5e3cc7  2021-09-01T19:51:47+00:00  40S       gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630525906.214886-616f3742d3f1419fb22f6ce994b18219.tgz  gcr.io/qwiklabs-gcp-01-64f200010379/monolith:2.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ kubectl set image deployment/monolith monolith=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0
deployment.apps/monolith image updated
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS              RESTARTS   AGE
pod/monolith-76f9d9c4b5-sp8jv   1/1     Running             0          7m51s
pod/monolith-786fbdc796-crw6w   0/1     ContainerCreating   0          20s
pod/orders-785878bbf6-zsf8d     1/1     Running             0          5m38s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1     <none>          443/TCP        12m
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213   80:32767/TCP   7m50s
service/orders       LoadBalancer   10.19.243.41    34.136.6.221    80:32465/TCP   5m12s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           7m51s
deployment.apps/orders     1/1     1            1           5m38s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-76f9d9c4b5   1         1         1       7m52s
replicaset.apps/monolith-786fbdc796   1         1         0       21s
replicaset.apps/orders-785878bbf6     1         1         1       5m39s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS        RESTARTS   AGE
pod/monolith-76f9d9c4b5-sp8jv   1/1     Terminating   0          7m58s
pod/monolith-786fbdc796-crw6w   1/1     Running       0          27s
pod/orders-785878bbf6-zsf8d     1/1     Running       0          5m45s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1     <none>          443/TCP        12m
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213   80:32767/TCP   7m57s
service/orders       LoadBalancer   10.19.243.41    34.136.6.221    80:32465/TCP   5m19s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           7m59s
deployment.apps/orders     1/1     1            1           5m46s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-76f9d9c4b5   0         0         0       7m59s
replicaset.apps/monolith-786fbdc796   1         1         1       28s
replicaset.apps/orders-785878bbf6     1         1         1       5m46s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/microservices/src/products
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/products:1.0.0 .
Creating temporary tarball archive of 8 file(s) totalling 20.2 KiB before compression.
Some files were not included in the source upload.

Check the gcloud log [/tmp/tmp.Z5LBMmi0ua/logs/2021.09.01/19.54.00.583322.log] to see which files and the contents of the
default gcloudignore file used (see `$ gcloud topic gcloudignore` to learn
more).

Uploading tarball of [.] to [gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526040.662963-37762283c45a441f9afb95348084bcf8.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-64f200010379/locations/global/builds/bd465bbf-e672-40fc-9ed3-8cc40c6b8803].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/bd465bbf-e672-40fc-9ed3-8cc40c6b8803?project=452830728646].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "bd465bbf-e672-40fc-9ed3-8cc40c6b8803"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526040.662963-37762283c45a441f9afb95348084bcf8.tgz#1630526041287233
Copying gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526040.662963-37762283c45a441f9afb95348084bcf8.tgz#1630526041287233...
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
04dccde934cf: Download complete
73269890f6fd: Verifying Checksum
73269890f6fd: Download complete
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
 ---> Running in f3e9a1e832c4
Removing intermediate container f3e9a1e832c4
 ---> 75da8a3061c3
Step 3/7 : COPY package*.json ./
 ---> 331b2217f737
Step 4/7 : RUN npm install
 ---> Running in 66c776a64aec
npm WARN products@1.0.0 No description
npm WARN products@1.0.0 No repository field.

added 52 packages from 39 contributors and audited 52 packages in 1.485s
found 0 vulnerabilities
Removing intermediate container 66c776a64aec
 ---> ef3d33d19a0f
Step 5/7 : COPY . .
 ---> 8f71784d1639
Step 6/7 : EXPOSE 8082
 ---> Running in 18ff5474469a
Removing intermediate container 18ff5474469a
 ---> 6f97ec054d8f
Step 7/7 : CMD [ "node", "server.js" ]
 ---> Running in 87c42e1858c3
Removing intermediate container 87c42e1858c3
 ---> 9f9284f5a7d9
Successfully built 9f9284f5a7d9
Successfully tagged gcr.io/qwiklabs-gcp-01-64f200010379/products:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-64f200010379/products:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-64f200010379/products]
377b34f13701: Preparing
591837185fa1: Preparing
e2cc04e57bff: Preparing
6f61bc5c465b: Preparing
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
377b34f13701: Pushed
6f61bc5c465b: Pushed
e2cc04e57bff: Pushed
591837185fa1: Pushed
1.0.0: digest: sha256:2cb4bd4916676a41b29c9bf9ff5fc12865383e0f4a7455a69712a6e10c7102ed size: 3049
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
bd465bbf-e672-40fc-9ed3-8cc40c6b8803  2021-09-01T19:54:01+00:00  40S       gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526040.662963-37762283c45a441f9afb95348084bcf8.tgz  gcr.io/qwiklabs-gcp-01-64f200010379/products:1.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ kubectl create deployment products --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/products:1.0.0
deployment.apps/products created
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/monolith-786fbdc796-crw6w   1/1     Running   0          2m23s
pod/orders-785878bbf6-zsf8d     1/1     Running   0          7m41s
pod/products-7b794f7965-vzk4t   1/1     Running   0          14s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1     <none>          443/TCP        14m
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213   80:32767/TCP   9m54s
service/orders       LoadBalancer   10.19.243.41    34.136.6.221    80:32465/TCP   7m16s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           9m55s
deployment.apps/orders     1/1     1            1           7m42s
deployment.apps/products   1/1     1            1           15s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-76f9d9c4b5   0         0         0       9m55s
replicaset.apps/monolith-786fbdc796   1         1         1       2m24s
replicaset.apps/orders-785878bbf6     1         1         1       7m42s
replicaset.apps/products-7b794f7965   1         1         1       15s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ kubectl expose deployment products --type=LoadBalancer --port 80 --target-port 8082
service/products exposed
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ kubectl get service products
NAME       TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
products   LoadBalancer   10.19.254.17   <pending>     80:31195/TCP   8s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ kubectl get service products
NAME       TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
products   LoadBalancer   10.19.254.17   <pending>     80:31195/TCP   34s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ kubectl get service products
NAME       TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)        AGE
products   LoadBalancer   10.19.254.17   34.134.242.199   80:31195/TCP   87s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/products (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/react-app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ nano .env.monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ npm run build:monolith

> frontend@0.1.0 build:monolith
> env-cmd -f .env.monolith react-scripts build

Creating an optimized production build...
Compiled successfully.

File sizes after gzip:

  79.08 KB        build/static/js/2.99058a84.chunk.js
  2.02 KB (+2 B)  build/static/js/main.80fa56d4.chunk.js
  770 B           build/static/js/runtime-main.c8a21426.js

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
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:3.0.0 .
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526335.674242-a4d348bebbc247c28283de4aa1e6dae7.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-64f200010379/locations/global/builds/2f705a24-921a-4c88-ba08-dbe5dfb21731].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/2f705a24-921a-4c88-ba08-dbe5dfb21731?project=452830728646].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "2f705a24-921a-4c88-ba08-dbe5dfb21731"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526335.674242-a4d348bebbc247c28283de4aa1e6dae7.tgz#1630526336947192
Copying gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526335.674242-a4d348bebbc247c28283de4aa1e6dae7.tgz#1630526336947192...
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
 ---> Running in 7267e2d8dfbc
Removing intermediate container 7267e2d8dfbc
 ---> 73c843de5f9f
Step 3/7 : COPY package*.json ./
 ---> d4e4ccbbff51
Step 4/7 : RUN npm install
 ---> Running in acde1e50edd7
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.511s
found 0 vulnerabilities

Removing intermediate container acde1e50edd7
 ---> ee3611ba6807
Step 5/7 : COPY . .
 ---> 83f897c1af3d
Step 6/7 : EXPOSE 8080
 ---> Running in e74053c73c4e
Removing intermediate container e74053c73c4e
 ---> cf9c81817381
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in a835505eac74
Removing intermediate container a835505eac74
 ---> aee5651c52ca
Successfully built aee5651c52ca
Successfully tagged gcr.io/qwiklabs-gcp-01-64f200010379/monolith:3.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-64f200010379/monolith:3.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-64f200010379/monolith]
ced31d1f5d9e: Preparing
b4d284ef6571: Preparing
30ec70bd3a3a: Preparing
ac1b3f1f7649: Preparing
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
c98dc9a94132: Waiting
3ffdb7e28503: Waiting
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
30ec70bd3a3a: Pushed
ac1b3f1f7649: Pushed
b4d284ef6571: Pushed
ced31d1f5d9e: Pushed
3.0.0: digest: sha256:a328c7bb3b445637c54a8c84cd052cdb85e24c7b7c44422b9b6af028af4eb5e5 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
2f705a24-921a-4c88-ba08-dbe5dfb21731  2021-09-01T19:58:57+00:00  40S       gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526335.674242-a4d348bebbc247c28283de4aa1e6dae7.tgz  gcr.io/qwiklabs-gcp-01-64f200010379/monolith:3.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ kubectl set image deployment/monolith monolith=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:3.0.0
deployment.apps/monolith image updated
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS              RESTARTS   AGE
pod/monolith-786fbdc796-crw6w   1/1     Running             0          6m48s
pod/monolith-bd6479b7-cmb77     0/1     ContainerCreating   0          15s
pod/orders-785878bbf6-zsf8d     1/1     Running             0          12m
pod/products-7b794f7965-vzk4t   1/1     Running             0          4m39s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        18m
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213    80:32767/TCP   14m
service/orders       LoadBalancer   10.19.243.41    34.136.6.221     80:32465/TCP   11m
service/products     LoadBalancer   10.19.254.17    34.134.242.199   80:31195/TCP   4m15s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           14m
deployment.apps/orders     1/1     1            1           12m
deployment.apps/products   1/1     1            1           4m40s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-76f9d9c4b5   0         0         0       14m
replicaset.apps/monolith-786fbdc796   1         1         1       6m49s
replicaset.apps/monolith-bd6479b7     1         1         0       17s
replicaset.apps/orders-785878bbf6     1         1         1       12m
replicaset.apps/products-7b794f7965   1         1         1       4m40s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS        RESTARTS   AGE
pod/monolith-786fbdc796-crw6w   1/1     Terminating   0          6m59s
pod/monolith-bd6479b7-cmb77     1/1     Running       0          26s
pod/orders-785878bbf6-zsf8d     1/1     Running       0          12m
pod/products-7b794f7965-vzk4t   1/1     Running       0          4m50s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
service/kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        18m
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213    80:32767/TCP   14m
service/orders       LoadBalancer   10.19.243.41    34.136.6.221     80:32465/TCP   11m
service/products     LoadBalancer   10.19.254.17    34.134.242.199   80:31195/TCP   4m26s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monolith   1/1     1            1           14m
deployment.apps/orders     1/1     1            1           12m
deployment.apps/products   1/1     1            1           4m51s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/monolith-76f9d9c4b5   0         0         0       14m
replicaset.apps/monolith-786fbdc796   0         0         0       7m
replicaset.apps/monolith-bd6479b7     1         1         1       28s
replicaset.apps/orders-785878bbf6     1         1         1       12m
replicaset.apps/products-7b794f7965   1         1         1       4m51s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/react-app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ cp .env.monolith .env
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ npm run build

> frontend@0.1.0 prebuild
> npm run build:monolith


> frontend@0.1.0 build:monolith
> env-cmd -f .env.monolith react-scripts build

Creating an optimized production build...
Compiled successfully.

File sizes after gzip:

  79.08 KB  build/static/js/2.99058a84.chunk.js
  2.02 KB   build/static/js/main.80fa56d4.chunk.js
  770 B     build/static/js/runtime-main.c8a21426.js

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

  79.08 KB  build/static/js/2.99058a84.chunk.js
  2.02 KB   build/static/js/main.80fa56d4.chunk.js
  770 B     build/static/js/runtime-main.c8a21426.js

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
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-01-64f200010379)$ cd ~/monolith-to-microservices/microservices/src/frontend
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/frontend:1.0.0 .
Creating temporary tarball archive of 31 file(s) totalling 2.3 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526444.043386-fa7d7a5d2eff4e2892b92a6c193cb07e.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-01-64f200010379/locations/global/builds/c3832bb4-9123-4e89-bf71-65752a747d87].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/c3832bb4-9123-4e89-bf71-65752a747d87?project=452830728646].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "c3832bb4-9123-4e89-bf71-65752a747d87"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526444.043386-fa7d7a5d2eff4e2892b92a6c193cb07e.tgz#1630526445182225
Copying gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526444.043386-fa7d7a5d2eff4e2892b92a6c193cb07e.tgz#1630526445182225...
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
b800e94e7303: Verifying Checksum
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
 ---> Running in 2cbade11c496
Removing intermediate container 2cbade11c496
 ---> 8db451f6a457
Step 3/7 : COPY package*.json ./
 ---> 954b91697a5c
Step 4/7 : RUN npm install
 ---> Running in d52a1de45be3
npm WARN frontend@1.0.0 No description
npm WARN frontend@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.623s
found 0 vulnerabilities
Removing intermediate container d52a1de45be3
 ---> f0719c12bec6
Step 5/7 : COPY . .
 ---> 6c8dc5090f32
Step 6/7 : EXPOSE 8080
 ---> Running in ebe9fca7cc2c
Removing intermediate container ebe9fca7cc2c
 ---> 07afdbe3fd6a
Step 7/7 : CMD [ "node", "server.js" ]
 ---> Running in acc8543a085b
Removing intermediate container acc8543a085b
 ---> 02baa185b1a4
Successfully built 02baa185b1a4
Successfully tagged gcr.io/qwiklabs-gcp-01-64f200010379/frontend:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-01-64f200010379/frontend:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-01-64f200010379/frontend]
a0b92c772a2d: Preparing
89cb96fa56b1: Preparing
a23669358365: Preparing
9d2e9ea5add0: Preparing
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
9d2e9ea5add0: Pushed
a23669358365: Pushed
89cb96fa56b1: Pushed
a0b92c772a2d: Pushed
1.0.0: digest: sha256:a1bb0c511317773bd0ea9b9a2ef4d5ebc6697c9c5bd8002f4e8afb20b0a87a26 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
c3832bb4-9123-4e89-bf71-65752a747d87  2021-09-01T20:00:45+00:00  42S       gs://qwiklabs-gcp-01-64f200010379_cloudbuild/source/1630526444.043386-fa7d7a5d2eff4e2892b92a6c193cb07e.tgz  gcr.io/qwiklabs-gcp-01-64f200010379/frontend:1.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl expose deployment frontend --type=LoadBalancer --port 80 --target-port 8080
Error from server (NotFound): deployments.apps "frontend" not found
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl create deployment frontend --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/frontend:1.0.0
deployment.apps/frontend created
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl expose deployment frontend --type=LoadBalancer --port 80 --target-port 8080
service/frontend exposed
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/frontend-77d556db49-vfgf5   1/1     Running   0          30s
pod/monolith-bd6479b7-cmb77     1/1     Running   0          2m42s
pod/orders-785878bbf6-zsf8d     1/1     Running   0          14m
pod/products-7b794f7965-vzk4t   1/1     Running   0          7m6s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
service/frontend     LoadBalancer   10.19.249.124   <pending>        80:30475/TCP   19s
service/kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        20m
service/monolith     LoadBalancer   10.19.249.143   35.224.27.213    80:32767/TCP   16m
service/orders       LoadBalancer   10.19.243.41    34.136.6.221     80:32465/TCP   14m
service/products     LoadBalancer   10.19.254.17    34.134.242.199   80:31195/TCP   6m41s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/frontend   1/1     1            1           30s
deployment.apps/monolith   1/1     1            1           16m
deployment.apps/orders     1/1     1            1           14m
deployment.apps/products   1/1     1            1           7m6s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/frontend-77d556db49   1         1         1       30s
replicaset.apps/monolith-76f9d9c4b5   0         0         0       16m
replicaset.apps/monolith-786fbdc796   0         0         0       9m15s
replicaset.apps/monolith-bd6479b7     1         1         1       2m43s
replicaset.apps/orders-785878bbf6     1         1         1       14m
replicaset.apps/products-7b794f7965   1         1         1       7m6s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
frontend-77d556db49-vfgf5   1/1     Running   0          45s
monolith-bd6479b7-cmb77     1/1     Running   0          2m57s
orders-785878bbf6-zsf8d     1/1     Running   0          14m
products-7b794f7965-vzk4t   1/1     Running   0          7m21s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
frontend     LoadBalancer   10.19.249.124   <pending>        80:30475/TCP   40s
kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        21m
monolith     LoadBalancer   10.19.249.143   35.224.27.213    80:32767/TCP   17m
orders       LoadBalancer   10.19.243.41    34.136.6.221     80:32465/TCP   14m
products     LoadBalancer   10.19.254.17    34.134.242.199   80:31195/TCP   7m2s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$ kubectl get svc
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)        AGE
frontend     LoadBalancer   10.19.249.124   34.69.135.29     80:30475/TCP   56s
kubernetes   ClusterIP      10.19.240.1     <none>           443/TCP        21m
monolith     LoadBalancer   10.19.249.143   35.224.27.213    80:32767/TCP   17m
orders       LoadBalancer   10.19.243.41    34.136.6.221     80:32465/TCP   14m
products     LoadBalancer   10.19.254.17    34.134.242.199   80:31195/TCP   7m18s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/microservices/src/frontend (qwiklabs-gcp-01-64f200010379)$
