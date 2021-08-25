You can list the active account name with this command:

$ gcloud auth list

You can list the project ID with this command:

$ gcloud config list project

Now upload an object into a bucket.

First, download this image to a temporary instance (ada.jpg) in Cloud Shell:

$ wget --output-document ada.jpg https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg

Use the gsutil cp command to upload the image from the location where you saved it to the bucket you created:

$ gsutil cp ada.jpg gs://YOUR-BUCKET-NAME

Now remove the downloaded image:

$ rm ada.jpg

Create a bucket
In the Cloud Console, go to Navigation menu > Cloud Storage > Browser. Click CREATE BUCKET:

Click CONTINUE.

Location type: Multi-region

Location: us (multiple regions in United States)

Click CONTINUE.

Default Storage class: Standard

Click CONTINUE.

Uncheck Enforce public access prevention on this bucket checkbox under Prevent public access.

Choose Fine-grained under Access Control.

Click CONTINUE.

Once you've gotten your bucket configured, click CREATE:

That's it — you've just created a Cloud Storage bucket!

Download an object from your bucket
Use the gsutil cp command to download the image you stored in your bucket to Cloud Shell:

$ gsutil cp -r gs://YOUR-BUCKET-NAME/ada.jpg .

Copy an object to a folder in the bucket
Use the gsutil cp command to create a folder called image-folder and copy the image (ada.jpg) into it:

$ gsutil cp gs://YOUR-BUCKET-NAME/ada.jpg gs://YOUR-BUCKET-NAME/image-folder/

List contents of a bucket or folder
Use the gsutil ls command to list the contents of the bucket:

$ gsutil ls gs://YOUR-BUCKET-NAME

List details for an object
Use the gsutil ls command, with the -l flag to get some details about the image file you uploaded to your bucket:

$ gsutil ls -l gs://YOUR-BUCKET-NAME/ada.jpg

Make your object publicly accessible
Use the gsutil acl ch command to grant all users read permission for the object stored in your bucket:

$ gsutil acl ch -u AllUsers:R gs://YOUR-BUCKET-NAME/ada.jpg

Remove public access
To remove this permission, use the command:

$ gsutil acl ch -d AllUsers gs://YOUR-BUCKET-NAME/ada.jpg

Delete objects
Use the gsutil rm command to delete an object - the image file in your bucket:

$ gsutil rm gs://YOUR-BUCKET-NAME/ada.jpg
