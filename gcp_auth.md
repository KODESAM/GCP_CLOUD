After Cloud Shell is provisioned, a new pane opens at the bottom of the console with messages and prompts like this:

Welcome to Cloud Shell! Type "help" to get started.
Your Cloud Platform project in this session is set to qwiklabs-gcp-76ad0f1342e20013.
Use "gcloud config set project [PROJECT_ID]" to change to a different project.
gcpstaging23396_student@cloudshell:~ (qwiklabs-gcp-76ad0f1342e20013)$

Run the following command and then click Authorize if prompted.
```
$ gcloud auth list
```
You should receive an output similar to this, where ACTIVE ACCOUNT is set to your Cloud IAM identity (gcpstagingxxxxx_student@qwiklabs.net):
```
Credentialed Accounts
ACTIVE  ACCOUNT
*       gcpstaging23396_student@qwiklabs.net
To set the active account, run:
    $ gcloud config set account `ACCOUNT`
```
