Create a new repository
Start a new session in Cloud Shell and run the following command to create a new Cloud Source Repository named REPO_DEMO:

gcloud source repos create REPO_DEMO

Clone the new repository into your Cloud Shell session
Clone the contents of your new Cloud Source Repository to a local repo in your Cloud Shell session:

gcloud source repos clone REPO_DEMO
The gcloud source repos clone command adds Cloud Source Repositories as a remote named origin and clones it into a local Git repository.

Push to the Cloud Source Repository
Go into the local repository you created:

cd REPO_DEMO
Run the following command to create a file myfile.txt in your local repository:

echo 'Hello World!' > myfile.txt
Commit the file using the following Git commands:

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git add myfile.txt
git commit -m "First file using Cloud Source Repositories" myfile.txt

Once you've committed code to the local repository, add its contents to Cloud Source Repositories using the git push command:

git push origin master

Browse files in the Google Cloud Source repository
Use the Google Cloud Source Repositories source code browser to view repository files. You can filter your view to focus on a specific branch, tag, or comment.

Browse the sample files you pushed to the repository by opening the Navigation menu and selecting Source Repositories.
