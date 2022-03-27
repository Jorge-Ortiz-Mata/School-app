# School project.

## Project development.



### Step 01. Prepare git repo and heroku app.

Don't forget to make a commit before to do the next step: `git commit -am "Commit description."` .

### Step 02. Installing Bootstrap and Fontawesome.

Don't forget to make a commit before to do the next step: `git commit -am "Commit description."` .

### Step 03. Install Haml and Simple form gems.

Don't forget to make a commit before to do the next step: `git commit -am "Commit description."` .

### Step 04. Generate courses scaffold.

1. Adding the render sintax in application.html.haml: `= render 'shared/header'`.

2. Create a folder shared/_header.html.haml and add the next code.

```
= link_to "SchoolApp", root_path
= link_to "Courses", courses_path, class:"btn btn-info"
= link_to "Privacy policy and terms", privacy_and_terms_path
```

3. In courses/index.html.harb we can create a nice table: ``%table.table``.

4. Adding validations to our model.

```
validates :title,  presence: true
validates :description, presence: true, length: { :minimum => 5 }
```

Don't forget to make a commit before to do the next step: `git commit -am "Commit description."` .

### Step 05. Add Rich Text.

1. Run the command: `rails action_text:install`

2. Run the migration: `rails db:migrate`

3. Go to Course model and the next code: `has_rich_text :description`.

## Gems.

### Haml Rails gem.

This gem provides a different sintax within your .html.erb files. Besides, it changes the .erb extension
to .haml extension. 

* Gem: `gem "haml-rails"`.
* Run the command: `rails haml:erb2haml`. 
* Type (Y) = Yes.

### Simple Form gem.

This gem is utilize in order to create simple and basic forms.

* Gem: `gem 'simple_form'`.
* Run the command: `rails generate simple_form:install`.

## Git.

### Edit commits.

In order to edit the latest commit, follow the next process:

* Type: `git commit -am "First commit"`
* Type: `git reset --soft HEAD~1`
* Type: `git status`

### Undo commits.

#### Commit before deploy it to Github

This section will cover information regarding to revert changes in the project.
If you did something in your project and you want to get back to the latest commit, 
following hte next steps:

* Type: `git status` in order to see what changed.
* Type: `git clean -fd`.
* Type: `git reset --hard`.

With this command, you will be able to get back to latest commit.

#### Commit to delete an existing commit in your Github repo.

Following these steps in order to delete the latest commit in your gihub repo:

* Type: `git reset HEAD^ --hard`.
* Type: `git push -f`

### Branches

This section will cover information regarding branches.

#### These are the lines using with branches:

* Make a commit.
* Create a new branch: `git branch jorge`.
* Switch to branch jorge: `git checkout jorge`
* Make all the changes in the project and add commit: `git commit -am "Text."`
* You can change to the master branch by typping: `git checkout master`.
* You can change to the branch name by typping: `git checkout name_branch`.
* Once done it, get back to master branch and type: `git merge jorge`.
* You can delete branches by typping: `git branch -d jorge`.

#### Other things to keep in mind:

You can create a branch whitin a branch. You can do this:
* `git checkout -b jorge1`

And within the branch jorge1, create the new branch:
* `git checkout -b jorge2`

And that's it.
    
You can create branches and swtich them by typping this command: 
    
* `git checkout -b jorge`