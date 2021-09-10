##### Create a Compute Engine instance #####
```
In the Cloud Console dashboard, go to Navigation menu > Compute Engine > VM instances, then click Create instance.
```
Fill in the fields as follows, leaving all other fields at the default value:
```
--------
Field	        Value
Name	        lamp-1-vm
Region	      us-central1 (Iowa)
Zone	        us-central1-a
Series	      N1
Machine type	n1-standard-2
Firewall	    check Allow HTTP traffic
--------
```
##### Add Apache2 HTTP Server to your instance #######
```
In the Cloud Console, click SSH to open a terminal to your instance.
```
Run the following commands in the SSH window to set up Apache2 HTTP Server:
```
$ sudo apt-get update
$ sudo apt-get install apache2 php7.0
$ sudo service apache2 restart
```

##### Create a Monitoring workspace #####

Now set up a Monitoring workspace that's tied to your Google Cloud Project. The following steps create a new account that has a free trial of Monitoring.
```
In the Cloud Console, click Navigation menu > Monitoring.
```
Wait for your workspace to be provisioned.

Install agents on the VM:

Run the Monitoring agent install script command in the SSH terminal of your VM instance to install the Cloud Monitoring agent.
```
$ curl -sSO https://dl.google.com/cloudagents/add-monitoring-agent-repo.sh
$ sudo bash add-monitoring-agent-repo.sh
$ sudo apt-get update
$ sudo apt-get install stackdriver-agent
```
Run the Logging agent install script command in the SSH terminal of your VM instance to install the Cloud Logging agent
```
$ curl -sSO https://dl.google.com/cloudagents/add-logging-agent-repo.sh
$ sudo bash add-logging-agent-repo.sh
$ sudo apt-get update
$ sudo apt-get install google-fluentd
```
Create an uptime check

Uptime checks verify that a resource is always accessible. For practice, create an uptime check to verify your VM is up.

In the Cloud Console, in the left menu, click Uptime checks, and then click Create Uptime Check.
```
Set the following fields:
Title: Lamp Uptime Check, then click Next.

Protocol:       HTTP

Resource Type: Instance

Applies to:    Single, lamp-1-vm

Path:          leave at default

Check Frequency: 1 min
```
Click on Next to leave the other details to default and click Test to verify that your uptime check can connect to the resource.

When you see a green check mark everything can connect. Click Create.

#####  Create an alerting policy #########

Use Cloud Monitoring to create one or more alerting policies.
```
In the left menu, click Alerting, and then click Create Policy.
```
Click Add Condition.

Set the following in the panel that opens, leave all other fields at the default value.
```
Target: Start typing "VM" in the resource type and metric field, and then select:

Resource Type: VM Instance (gce_instance)

Metric: Type "network", and then select Network traffic (gce_instance+1). 

Be sure to choose the Network traffic resource with agent.googleapis.com/interface/traffic:
```
Configuration
```
Condition: is above
Threshold: 500
For: 1 minute
Click ADD.
```
Click on Next.
```
Click on drop down arrow next to Notification Channels, then click on Manage Notification Channels.

Scroll down the page and click on ADD NEW for Email.
```
```

In Create Email Channel dialog box, enter your personal email address in the Email Address field and a Display name.

Click on Save.
```
```
Go back to the previous Create alerting policy tab.

Click on Notification Channels again, then click on the Refresh icon to get the display name you mentioned in the previous step.

Now, select your Display name and click OK.

Click Next.
```
```
Mention the Alert name as Inbound Traffic Alert.

Add a message in documentation, which will be included in the emailed alert.

Click on Save.
```

You've created an alert! While you wait for the system to trigger an alert, create a dashboard and chart, and then check out Cloud Logging.

#####  Create a dashboard and chart ######

You can display the metrics collected by Cloud Monitoring in your own charts and dashboards. In this section you create the charts for the lab metrics and a custom dashboard.
```
In the left menu select Dashboards, and then Create Dashboard.

Name the dashboard Cloud Monitoring LAMP Qwik Start Dashboard.

Add the first chart

Click Line option in Chart library.

Name the chart title CPU Load.

Set the Resource type to VM Instance.

Set the Metric CPU load (1m).

Add the second chart

Click + Add Chart and select Line option in Chart library.

Name this chart Received Packets.

Set the resource type to VM Instance.

Set the Metric Received packets (gce_instance). Refresh the tab to view the graph.

Leave the other fields at their default values. You see the chart data.
```
###### View your logs  ##########

Cloud Monitoring and Cloud Logging are closely integrated. Check out the logs for your lab.
```
Select Navigation menu > Logging > Logs Explorer.

Select the logs you want to see, in this case, you select the logs for the lamp-1-vm instance you created at the start of this lab:

Select VM Instance > lamp-1-vm in the Resource drop-down menu.

Click Add.

Leave the other fields with their default values.

Click the Stream logs.
```
```

Check out what happens when you start and stop the VM instance.
To best see how Cloud Monitoring and Cloud Logging reflect VM instance changes, 
make changes to your instance in one browser window and then see what happens in the Cloud Monitoring, and then Cloud Logging windows.
```
Open the Compute Engine window in a new browser window. 
```
Select Navigation menu > Compute Engine, right-click VM instances > Open link in new window.

Move the Logs Viewer browser window next to the Compute Engine window. This makes it easier to view how changes to the VM are reflected in the logs.

In the Compute Engine window, select the lamp-1-vm instance, click Stop at the top of the screen, and then confirm to stop the instance.

Watch in the Logs View tab for when the VM is stopped.
```
In the VM instance details window, click Start at the top of the screen, and then confirm. It will take a few minutes for the instance to re-start.

Watch the log messages to monitor the start up.

##  Check the uptime check results and triggered alerts ##
```
In the Cloud Logging window, select Navigation menu > Monitoring > Uptime checks. This view provides a list of all active uptime checks, and the status of each in different locations.
You will see Lamp Uptime Check listed. Since you have just restarted your instance, the regions are in a failed status. It may take up to 5 minutes for the regions to become active. Reload your browser window as necessary until the regions are active.

Click the name of the uptime check, Lamp Uptime Check.
Since you have just restarted your instance, it may take some minutes for the regions to become active. Reload your browser window as necessary.
```
##### Check if alerts have been triggered #####
```
In the left menu, click Alerting.

You see incidents and events listed in the Alerting window.

Check your email account. You should see Cloud Monitoring Alerts.
```
