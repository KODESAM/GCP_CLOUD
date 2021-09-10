### To create a cloud function: ####

In the Cloud Shell command line, create a directory for the function code.
```
$ mkdir gcf_hello_world
```
Move to the gcf_hello_world directory.
```
$ cd gcf_hello_world
```
Create and open index.js to edit.
```
$ nano index.js
```
Copy the following into the index.js file
```
/**
* Background Cloud Function to be triggered by Pub/Sub.
* This function is exported by index.js, and executed when
* the trigger topic receives a message.
*
* @param {object} data The event payload.
* @param {object} context The event metadata.
*/
exports.helloWorld = (data, context) => {
const pubSubMessage = data;
const name = pubSubMessage.data
    ? Buffer.from(pubSubMessage.data, 'base64').toString() : "Hello World";
console.log(`My Cloud Function: ${name}`);
};

Exit nano (Ctrl+x) and save (Y) the file.
```
### Create a cloud storage bucket ####

Use the following command to create a new cloud storage bucket for your function:
```
$ gsutil mb -p [PROJECT_ID] gs://[BUCKET_NAME]
```
#### Deploy your function #####

When deploying a new function, you must specify --trigger-topic, --trigger-bucket, or --trigger-http. 
When deploying an update to an existing function, the function keeps the existing trigger unless otherwise specified.

For this lab, you'll set the --trigger-topic as hello_world.

Deploy the function to a pub/sub topic named hello_world, replacing [BUCKET_NAME] with the name of your bucket:
```
$ gcloud functions deploy helloWorld \
  --stage-bucket [BUCKET_NAME] \
  --trigger-topic hello_world \
  --runtime nodejs8
```
Verify the status of the function.
```
$ gcloud functions describe helloWorld
```
An ACTIVE status indicates that the function has been deployed.
```
entryPoint: helloWorld
eventTrigger:
  eventType: providers/cloud.pubsub/eventTypes/topic.publish
  failurePolicy: {}
  resource:
...
status: ACTIVE
...
```
###  Test the function  ###

After you deploy the function and know that it's active, test that the function writes a message to the cloud log after detecting an event.

Enter this command to create a message test of the function.
```
$ DATA=$(printf 'Hello World!'|base64) && gcloud functions call helloWorld --data '{"data":"'$DATA'"}'
```
The cloud tool returns the execution ID for the function, which means a message has been written in the log.

Example output:
```
executionId: 3zmhpf7l6j5b
```
View logs to confirm that there are log messages with that execution ID.

### View logs ####
Check the logs to see your messages in the log history.
```
$ gcloud functions logs read helloWorld
```
If the function executed successfully, messages in the log appear as follows:
```
LEVEL  NAME        EXECUTION_ID  TIME_UTC                 LOG
D      helloWorld  3zmhpf7l6j5b  2017-12-05 22:17:42.585  Function execution started
I      helloWorld  3zmhpf7l6j5b  2017-12-05 22:17:42.650  My Cloud Function: Hello World!
D      helloWorld  3zmhpf7l6j5b  2017-12-05 22:17:42.666  Function execution took 81 ms, finished with status: 'ok'
```
