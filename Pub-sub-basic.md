######  The Pub/Sub basics  ######

As stated earlier, Google Cloud Pub/Sub is an asynchronous global messaging service. There are three terms in Pub/Sub that appear often: topics, publishing, and subscribing.

A topic is a shared string that allows applications to connect with one another through a common thread.

Publishers push (or publish) a message to a Cloud Pub/Sub topic.

Subscribers make a "subscription" to a topic where they will either pull messages from the subscription or configure webhooks for push subscriptions. Every subscriber must acknowledge each message within a configurable window of time.

To sum it up, a producer publishes messages to a topic and a consumer creates a subscription to a topic to receive messages from it.

###### Pub/Sub topics ######

Pub/Sub comes preinstalled in the Google Cloud Shell, so there are no installations or configurations required to get started with this service.

Run the following command to create a topic called myTopic:

```
$ gcloud pubsub topics create myTopic
```
For good measure, create two more topics; one called Test1 and the other called Test2:
```
$ gcloud pubsub topics create Test1
$ gcloud pubsub topics create Test2
```
To see the three topics you just created, run the following command:
```
$ gcloud pubsub topics list
```
Your output should resemble the following:
```
name: projects/qwiklabs-gcp-3450558d2b043890/topics/myTopic
---
name: projects/qwiklabs-gcp-3450558d2b043890/topics/Test2
---
name: projects/qwiklabs-gcp-3450558d2b043890/topics/Test1
```
Time to cleanup. Delete Test1 and Test2 by running the following commands:
```
$ gcloud pubsub topics delete Test1
$ gcloud pubsub topics delete Test2
```
Run the gcloud pubsub topics list command one more time to verify the topics were deleted:
```
$ gcloud pubsub topics list
```
You should get the following output:
```
---
name: projects/qwiklabs-gcp-3450558d2b043890/topics/myTopic
```
##### Pub/Sub subscriptions #####

Now that you're comfortable creating, viewing, and deleting topics, time to work with subscriptions.

Run the following command to create a subscription called mySubscription to topic myTopic:
```
$ gcloud  pubsub subscriptions create --topic myTopic mySubscription
```
Add another two subscriptions to myTopic. Run the following commands to make Test1 and Test2 subscriptions:
```
$ gcloud  pubsub subscriptions create --topic myTopic Test1
$ gcloud  pubsub subscriptions create --topic myTopic Test2
```
Run the following command to list the subscriptions to myTopic:
```
$ gcloud pubsub topics list-subscriptions myTopic
```
Your output should resemble the following:
```
---
  projects/qwiklabs-gcp-3450558d2b043890/subscriptions/Test2
---
  projects/qwiklabs-gcp-3450558d2b043890/subscriptions/Test1
---
  projects/qwiklabs-gcp-3450558d2b043890/subscriptions/mySubscription
```  
  Now delete the Test1 and Test2 subscriptions. Run the following commands:
```
$ gcloud pubsub subscriptions delete Test1
$ gcloud pubsub subscriptions delete Test2
```
See if the Test1 and Test2 subscriptions were deleted. Run the list-subscriptions command one more time:
```
$ gcloud pubsub topics list-subscriptions myTopic
```
You should get the following output:
```
---
  projects/qwiklabs-gcp-3450558d2b043890/subscriptions/mySubscription
```  
 ##### Pub/Sub Publishing and Pulling a Single Message #####
 
Next you'll learn how to publish a message to a Pub/Sub topic.

Run the following command to publish the message "hello" to the topic you created previously (myTopic):
```
$ gcloud pubsub topics publish myTopic --message "Hello"
```
Publish a few more messages to myTopic. Run the following commands (replacing <YOUR NAME> with your name and <FOOD> with a food you like to eat):
```
$ gcloud pubsub topics publish myTopic --message "Publisher's name is <YOUR NAME>"
$ gcloud pubsub topics publish myTopic --message "Publisher likes to eat <FOOD>"
$ gcloud pubsub topics publish myTopic --message "Publisher thinks Pub/Sub is awesome"
```
next, use the pull command to get the messages from your topic. The pull command is subscription based, meaning it should work because earlier you set up the subscription mySubscription to the topic myTopic.

Use the following command to pull the messages you just published from the Pub/Sub topic:
```
$ gcloud pubsub subscriptions pull mySubscription --auto-ack
```
Now is an important time to note a couple features of the pull command that often trip developers up:

Using the pull command without any flags will output only one message, even if you are subscribed to a topic that has more held in it.
Once an individual message has been outputted from a particular subscription-based pull command, you cannot access that message again with the pull command.
To see what the second bullet is talking about, run the last command three more times. You will see that it will output the other messages you published before.

Now, run the command a 4th time. You'll get the following output (since there were none left to return):
```
gcpstaging20394_student@cloudshell:~ (qwiklabs-gcp-3450558d2b043890)$ gcloud pubsub subscriptions pull mySubscription --auto-ack
```
Listed 0 items.
In the last section, you will learn how to pull multiple messages from a topic with a flag.

##### Pub/Sub pulling all messages from subscriptions #####

Since you pulled all of the messages from your topic in hte last example, populate myTopic with a few more messages.

Run the following commands:
```
$ gcloud pubsub topics publish myTopic --message "Publisher is starting to get the hang of Pub/Sub"
$ gcloud pubsub topics publish myTopic --message "Publisher wonders if all messages will be pulled"
$ gcloud pubsub topics publish myTopic --message "Publisher will have to test to find out"
```
Add a flag to your command so you can output all three messages in one request. You may have not noticed, but you have actually been using a flag this entire time: the --auto-ack part of the pull command is a flag that has been formatting your messages into the neat boxes that you see your pulled messages in.

limit is another flag that sets an upper limit on the number of messages to pull.

Wait a minute to let the topics get created. Run the pull command with the limit flag:
```
$ gcloud pubsub subscriptions pull mySubscription --auto-ack --limit=3
```
