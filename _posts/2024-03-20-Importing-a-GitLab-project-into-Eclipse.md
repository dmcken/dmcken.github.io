---
title: Importing a GitLab project into Eclipse
date: 2024-03-20 00:00:01 -0400
categories: [Coding, Eclipse]
tags: [eclipse, git]
author: dmcken 
comments: false
---



<p>Setting up a new project in eclipse currently requires a separate working directory, personally I prefer for everything to be in the workspace directory.</p>

<p>First go to Eclipse and create a blank project with the settings you require.</p>


<p>Next open a terminal / command prompt in the folder of that project (i.e. &lt;path to workspace&gt;\&lt;project_name&gt;) and execute the following commands.</p>

```bash
git init
git remote add origin <PATH_TO_REPO>
git fetch
git reset origin/master <- This is only required if there are files that clash between the git repo and the local directory.
git checkout -t origin/master
```

* PATH_TO_REPO - URL to clone the repository (e.g. git@github.com:angular/angular.git or the matching HTTPS url as appropriate).
* Only do the reset if you have clashing files (given that this should be a blank project there should be none (unless you check in your project settings to which I ask "Why?").

<p>Ok, at this point you could edit as usual in eclipse (you might need to refresh the project to pick up the checked out files if you left eclipse open) but it doesn't know about the repo yet. So unless you want to manage the repo from command line lets get that information into eclipse.</p>

<p>First will be to right click on the project and go to the team sub-menu and share the project.</p>

![eclipse-team-menu](/assets/img/2024-03-20-Eclipse-Share-Project.png)

You should then be faced with a dialog similar to the following, everything should be left as is as it should automatically detect the .git folder and thus the repo in the project directory, for this dialog you specifically want the checkbox labeled "Use or create repository in parent folder of project":

![eclipse-share-project](/assets/img/2024-03-20-Share-project-dialog.png)

Which after simply pressing finish to accept the team menu now opens up fully:

![eclipse-project-shared-successfully](/assets/img/2024-03-20-Eclipse-project-shared-successfully.png)
