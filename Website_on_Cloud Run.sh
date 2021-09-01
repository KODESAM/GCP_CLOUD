Welcome to Cloud Shell! Type "help" to get started.
Your Cloud Platform project in this session is set to qwiklabs-gcp-03-745b7bbf381d.
Use “gcloud config set project [PROJECT_ID]” to change to a different project.
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-03-745b7bbf381d)$ gcloud auth list
           Credentialed Accounts
ACTIVE  ACCOUNT
*       student-01-d8f47e91d77f@qwiklabs.net

To set the active account, run:
    $ gcloud config set account `ACCOUNT`

student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-03-745b7bbf381d)$ git clone https://github.com/googlecodelabs/monolith-to-microservices.git
Cloning into 'monolith-to-microservices'...
remote: Enumerating objects: 988, done.
remote: Counting objects: 100% (52/52), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 988 (delta 39), reused 0 (delta 0), pack-reused 936
Receiving objects: 100% (988/988), 2.82 MiB | 10.76 MiB/s, done.
Resolving deltas: 100% (440/440), done.
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-03-745b7bbf381d)$ ls -l
total 8
drwxr-xr-x 7 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:48 monolith-to-microservices
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f  913 Sep  1 03:48 README-cloudshell.txt
student_01_d8f47e91d77f@cloudshell:~ (qwiklabs-gcp-03-745b7bbf381d)$ cd monolith-to-microservices/
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-03-745b7bbf381d)$ ls -l
total 40
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1100 Sep  1 03:48 CONTRIBUTING.md
-rwxr-xr-x 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1348 Sep  1 03:48 deploy-monolith.sh
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f  552 Sep  1 03:48 LICENSE
drwxr-xr-x 2 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:48 logs
drwxr-xr-x 3 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:48 microservices
drwxr-xr-x 5 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:48 monolith
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f   27 Sep  1 03:48 package-lock.json
drwxr-xr-x 5 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:48 react-app
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 3321 Sep  1 03:48 README.md
-rwxr-xr-x 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1372 Sep  1 03:48 setup.sh
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-03-745b7bbf381d)$ ./setup.sh
Checking for required npm version...Completed.
Installing monolith dependencies...Completed.
Installing microservies dependencies...Completed.
Installing React app dependencies...Completed.
Building React app and placing into sub projects...Completed.

Script completed successfully!
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-03-745b7bbf381d)$ ls -l
total 40
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1100 Sep  1 03:48 CONTRIBUTING.md
-rwxr-xr-x 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1348 Sep  1 03:48 deploy-monolith.sh
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f  552 Sep  1 03:48 LICENSE
drwxr-xr-x 2 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:50 logs
drwxr-xr-x 4 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:49 microservices
drwxr-xr-x 7 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:51 monolith
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f   27 Sep  1 03:48 package-lock.json
drwxr-xr-x 7 student_01_d8f47e91d77f student_01_d8f47e91d77f 4096 Sep  1 03:50 react-app
-rw-r--r-- 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 3321 Sep  1 03:48 README.md
-rwxr-xr-x 1 student_01_d8f47e91d77f student_01_d8f47e91d77f 1372 Sep  1 03:48 setup.sh
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices (qwiklabs-gcp-03-745b7bbf381d)$ cd ~/monolith-to-microservices/monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ npm start

> monolith@1.0.0 start
> node ./src/server.js

Monolith listening on port 8080!
^C
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud services enable cloudbuild.googleapis.com
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 .
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630468387.015439-bbd0ec2e276c44d8bf003c9ac9f8ecb8.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-03-745b7bbf381d/locations/global/builds/b57bb551-7e7e-4383-94fa-6ccc4d2dc19c].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/b57bb551-7e7e-4383-94fa-6ccc4d2dc19c?project=605989430762].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "b57bb551-7e7e-4383-94fa-6ccc4d2dc19c"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630468387.015439-bbd0ec2e276c44d8bf003c9ac9f8ecb8.tgz#1630468389469598
Copying gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630468387.015439-bbd0ec2e276c44d8bf003c9ac9f8ecb8.tgz#1630468389469598...
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
 ---> Running in 096a0a7edcf3
Removing intermediate container 096a0a7edcf3
 ---> 9a3a94aa4d4d
Step 3/7 : COPY package*.json ./
 ---> 029f9be8238d
Step 4/7 : RUN npm install
 ---> Running in c1e28334a460
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.506s
found 0 vulnerabilities
Removing intermediate container c1e28334a460
 ---> 5579395993fe
Step 5/7 : COPY . .
 ---> 0b3998d4714c
Step 6/7 : EXPOSE 8080
 ---> Running in f51659d3adeb
Removing intermediate container f51659d3adeb
 ---> c7dff89ba0fe
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in 160a332de39c
Removing intermediate container 160a332de39c
 ---> 01fa776b0b87
Successfully built 01fa776b0b87
Successfully tagged gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:1.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:1.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith]
814e11293d3d: Preparing
fa0efd465b12: Preparing
26fed54bd863: Preparing
575040926d4c: Preparing
3ab01e8988bf: Preparing
c98dc9a94132: Preparing
3ffdb7e28503: Preparing
c98dc9a94132: Waiting
33dd93485756: Preparing
607d71c12b77: Preparing
052174538f53: Preparing
3ffdb7e28503: Waiting
33dd93485756: Waiting
607d71c12b77: Waiting
8abfe7e7c816: Preparing
c8b886062a47: Preparing
16fc2e3ca032: Preparing
8abfe7e7c816: Waiting
c8b886062a47: Waiting
16fc2e3ca032: Waiting
052174538f53: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
607d71c12b77: Layer already exists
052174538f53: Layer already exists
575040926d4c: Pushed
fa0efd465b12: Pushed
26fed54bd863: Pushed
814e11293d3d: Pushed
8abfe7e7c816: Layer already exists
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
1.0.0: digest: sha256:8b543dbeeb734494193e747011d90a0bad0961f6343a493765f69288d8800fe6 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
b57bb551-7e7e-4383-94fa-6ccc4d2dc19c  2021-09-01T03:53:10+00:00  44S       gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630468387.015439-bbd0ec2e276c44d8bf003c9ac9f8ecb8.tgz  gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:1.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud services enable run.googleapis.com
Operation "operations/acf.p2-605989430762-fc608238-1a1b-48f6-9098-8fc3b8f9f4ee" finished successfully.
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run deploy --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 --platform managed
Service name (monolith):
Please specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  23

To make this the default region, run `gcloud config set run/region us-east1`.

Allow unauthenticated invocations to [monolith] (y/N)?  y

Deploying container to Cloud Run service [monolith] in project [qwiklabs-gcp-03-745b7bbf381d] region [us-east1]
✓ Deploying new service... Done.                                                           
  ✓ Creating Revision...
  ✓ Routing traffic...
  ✓ Setting IAM Policy...
Done.
Service [monolith] revision [monolith-00001-vuk] has been deployed and is serving 100 percent of traffic.
Service URL: https://monolith-jjncpgpg2q-ue.a.run.app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run services list
   SERVICE   REGION    URL                                       LAST DEPLOYED BY                      LAST DEPLOYED AT
✔  monolith  us-east1  https://monolith-jjncpgpg2q-ue.a.run.app  student-01-d8f47e91d77f@qwiklabs.net  2021-09-01T03:58:27.163963Z
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run deploy --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 --platform managed --concurrency 1
Service name (monolith):
Please specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  23

To make this the default region, run `gcloud config set run/region us-east1`.

Deploying container to Cloud Run service [monolith] in project [qwiklabs-gcp-03-745b7bbf381d] region [us-east1]
✓ Deploying... Done.                                         
  ✓ Creating Revision...
  ✓ Routing traffic...
Done.
Service [monolith] revision [monolith-00002-meb] has been deployed and is serving 100 percent of traffic.
Service URL: https://monolith-jjncpgpg2q-ue.a.run.app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run deploy --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 --platform managed --concurrency 80
Service name (monolith):
Please specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  23

To make this the default region, run `gcloud config set run/region us-east1`.

Deploying container to Cloud Run service [monolith] in project [qwiklabs-gcp-03-745b7bbf381d] region [us-east1]
✓ Deploying... Done.                                         
  ✓ Creating Revision...
  ✓ Routing traffic...
Done.
Service [monolith] revision [monolith-00003-kuy] has been deployed and is serving 100 percent of traffic.
Service URL: https://monolith-jjncpgpg2q-ue.a.run.app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ cd ~/monolith-to-microservices/react-app/src/pages/Home
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app/src/pages/Home (qwiklabs-gcp-03-745b7bbf381d)$ mv index.js.new index.js
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app/src/pages/Home (qwiklabs-gcp-03-745b7bbf381d)$ cat ~/monolith-to-microservices/react-app/src/pages/Home/index.js
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
}student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app/src/pages/Home (qwiklabs-gcp-03-745b7bbf381d)$ cd ~/monolith-to-microservices/react-apstudent_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-03-745b7bbf381d)$ npm run build:monolith

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
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/react-app (qwiklabs-gcp-03-745b7bbf381d)$ cd ~/monolith-to-microservices/monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ #Feel free to test your application
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ npm start

> monolith@1.0.0 start
> node ./src/server.js

Monolith listening on port 8080!

^C
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 .
Creating temporary tarball archive of 33 file(s) totalling 2.4 MiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630469265.642947-0027b724ccf54a0c990926913a7efd34.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-03-745b7bbf381d/locations/global/builds/53d8aa08-afa6-496a-989c-792e335522ec].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/53d8aa08-afa6-496a-989c-792e335522ec?project=605989430762].
--------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------
starting build "53d8aa08-afa6-496a-989c-792e335522ec"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630469265.642947-0027b724ccf54a0c990926913a7efd34.tgz#1630469266860301
Copying gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630469265.642947-0027b724ccf54a0c990926913a7efd34.tgz#1630469266860301...
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
b53ce1fd2746: Verifying Checksum
b53ce1fd2746: Download complete
2e2bafe8a0f4: Verifying Checksum
2e2bafe8a0f4: Download complete
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
 ---> Running in 6d75a6c84b80
Removing intermediate container 6d75a6c84b80
 ---> b3275a03b77e
Step 3/7 : COPY package*.json ./
 ---> 3be7a0a0da58
Step 4/7 : RUN npm install
 ---> Running in d476ee4071d0
npm WARN read-shrinkwrap This version of npm is compatible with lockfileVersion@1, but package-lock.json was generated for lockfileVersion@2. I'll try to do my best with it!
npm WARN monolith@1.0.0 No description
npm WARN monolith@1.0.0 No repository field.

added 50 packages from 37 contributors and audited 50 packages in 1.799s
found 0 vulnerabilities

Removing intermediate container d476ee4071d0
 ---> 1dc0dfcf887e
Step 5/7 : COPY . .
 ---> 23f57b5e787a
Step 6/7 : EXPOSE 8080
 ---> Running in 29f52e06dfd8
Removing intermediate container 29f52e06dfd8
 ---> a8f646b60447
Step 7/7 : CMD [ "node", "src/server.js" ]
 ---> Running in ab7e7a3c2931
Removing intermediate container ab7e7a3c2931
 ---> e86850f12f48
Successfully built e86850f12f48
Successfully tagged gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0
PUSH
Pushing gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0
The push refers to repository [gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith]
f50d0addae7c: Preparing
fac73e02c7a7: Preparing
8a50a85d3c9f: Preparing
9bd6b7d5f6be: Preparing
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
16fc2e3ca032: Waiting
c8b886062a47: Waiting
3ab01e8988bf: Layer already exists
c98dc9a94132: Layer already exists
3ffdb7e28503: Layer already exists
33dd93485756: Layer already exists
607d71c12b77: Layer already exists
052174538f53: Layer already exists
8abfe7e7c816: Layer already exists
c8b886062a47: Layer already exists
16fc2e3ca032: Layer already exists
8a50a85d3c9f: Pushed
9bd6b7d5f6be: Pushed
f50d0addae7c: Pushed
fac73e02c7a7: Pushed
2.0.0: digest: sha256:9b9b49a7651e8ea83061b54956066ee16e247dbd15049dcdacbd5cf5f8c42905 size: 3052
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                              STATUS
53d8aa08-afa6-496a-989c-792e335522ec  2021-09-01T04:07:47+00:00  42S       gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630469265.642947-0027b724ccf54a0c990926913a7efd34.tgz  gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0  SUCCESS
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run deploy --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 --platform managed
Service name (monolith):
Please specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  24

To make this the default region, run `gcloud config set run/region us-east4`.

Allow unauthenticated invocations to [monolith] (y/N)?  y

Deploying container to Cloud Run service [monolith] in project [qwiklabs-gcp-03-745b7bbf381d] region [us-east4]
✓ Deploying new service... Done.                                       
  ✓ Creating Revision... Revision deployment finished. Waiting for health check to begin.
  ✓ Routing traffic...
  ✓ Setting IAM Policy...
Done.
Service [monolith] revision [monolith-00001-siw] has been deployed and is serving 100 percent of traffic.
Service URL: https://monolith-jjncpgpg2q-uk.a.run.app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run deploy --image=gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 --platform managed
Service name (monolith):
Please specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  23

To make this the default region, run `gcloud config set run/region us-east1`.

Deploying container to Cloud Run service [monolith] in project [qwiklabs-gcp-03-745b7bbf381d] region [us-east1]
✓ Deploying... Done.                                         
  ✓ Creating Revision...
  ✓ Routing traffic...
Done.
Service [monolith] revision [monolith-00004-loj] has been deployed and is serving 100 percent of traffic.
Service URL: https://monolith-jjncpgpg2q-ue.a.run.app
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run services describe monolith --platform managedPlease specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  ^C

Command killed by keyboard interrupt


student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run services describe monolith --platform managedPlease specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  23

To make this the default region, run `gcloud config set run/region us-east1`.

✔ Service monolith in region us-east1

URL:     https://monolith-jjncpgpg2q-ue.a.run.app
Ingress: all
Traffic:
  100% LATEST (currently monolith-00004-loj)

Last updated on 2021-09-01T04:11:55.872749Z by student-01-d8f47e91d77f@qwiklabs.net:
  Revision monolith-00004-loj
  Image:         gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0
  Port:          8080
  Memory:        512Mi
  CPU:           1000m
  Concurrency:   80
  Max Instances: 100
  Timeout:       300s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud run services describe monolith --platform managedPlease specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:
Please enter a value between 1 and 29:  24

To make this the default region, run `gcloud config set run/region us-east4`.

✔ Service monolith in region us-east4

URL:     https://monolith-jjncpgpg2q-uk.a.run.app
Ingress: all
Traffic:
  100% LATEST (currently monolith-00001-siw)

Last updated on 2021-09-01T04:10:22.280749Z by student-01-d8f47e91d77f@qwiklabs.net:
  Revision monolith-00001-siw
  Image:         gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0
  Port:          8080
  Memory:        512Mi
  CPU:           1000m
  Concurrency:   80
  Max Instances: 100
  Timeout:       300s
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud beta run services list
   SERVICE   REGION    URL                                       LAST DEPLOYED BY                      LAST DEPLOYED AT
✔  monolith  us-east1  https://monolith-jjncpgpg2q-ue.a.run.app  student-01-d8f47e91d77f@qwiklabs.net  2021-09-01T04:11:55.872749Z
✔  monolith  us-east4  https://monolith-jjncpgpg2q-uk.a.run.app  student-01-d8f47e91d77f@qwiklabs.net  2021-09-01T04:10:22.280749Z
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ # Delete the container image for version 1.0.0 of our monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud container images delete gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:1.0.0 --quiet

Digests:
- gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith@sha256:8b543dbeeb734494193e747011d90a0bad0961f6343a493765f69288d8800fe6
  Associated tags:
 - 1.0.0
Tags:
- gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:1.0.0
Deleted [gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:1.0.0].
Deleted [gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith@sha256:8b543dbeeb734494193e747011d90a0bad0961f6343a493765f69288d8800fe6].
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ # Delete the container image for version 2.0.0 of our monolith
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud container images delete gcr.io/${GOOGLE_CLOUD_PROJECT}/monolith:2.0.0 --quiet
Digests:
- gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith@sha256:9b9b49a7651e8ea83061b54956066ee16e247dbd15049dcdacbd5cf5f8c42905
  Associated tags:
 - 2.0.0
Tags:
- gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0
Deleted [gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith:2.0.0].
Deleted [gcr.io/qwiklabs-gcp-03-745b7bbf381d/monolith@sha256:9b9b49a7651e8ea83061b54956066ee16e247dbd15049dcdacbd5cf5f8c42905].
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ # The following command will take all source archives from all builds and delete them from cloud storage
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ # Run this command to print all sources:
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ # gcloud builds list | awk 'NR > 1 {print $4}'
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud builds list | awk 'NR > 1 {print $4}' | while read line; do gsutil rm $line; done
Removing gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630469265.642947-0027b724ccf54a0c990926913a7efd34.tgz...
/ [1 objects]
Operation completed over 1 objects.
Removing gs://qwiklabs-gcp-03-745b7bbf381d_cloudbuild/source/1630468387.015439-bbd0ec2e276c44d8bf003c9ac9f8ecb8.tgz...
/ [1 objects]
Operation completed over 1 objects.
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$ gcloud beta run services delete monolith --platform managed
Please specify a region:
 [1] asia-east1
 [2] asia-east2
 [3] asia-northeast1
 [4] asia-northeast2
 [5] asia-northeast3
 [6] asia-south1
 [7] asia-south2
 [8] asia-southeast1
 [9] asia-southeast2
 [10] australia-southeast1
 [11] australia-southeast2
 [12] europe-central2
 [13] europe-north1
 [14] europe-west1
 [15] europe-west2
 [16] europe-west3
 [17] europe-west4
 [18] europe-west6
 [19] northamerica-northeast1
 [20] northamerica-northeast2
 [21] southamerica-east1
 [22] us-central1
 [23] us-east1
 [24] us-east4
 [25] us-west1
 [26] us-west2
 [27] us-west3
 [28] us-west4
 [29] cancel
Please enter your numeric choice:  23

To make this the default region, run `gcloud config set run/region us-east1`.

Service [monolith] will be deleted.

Do you want to continue (Y/n)?  y

Deleting [monolith]...done.                     
Deleted service [monolith].
student_01_d8f47e91d77f@cloudshell:~/monolith-to-microservices/monolith (qwiklabs-gcp-03-745b7bbf381d)$
