# School project.

## Project development.



### Step 01. Prepare git repo and heroku app.

Don't forget to make a commit before to do the next step: `git commit -am "Commit description."` .

### Step 02. Installing Bootstrap and Fontawesome.

1. Create a folder with a file in it: `app/javascript/stylesheets/application.scss`

2. In enviroment.js, add the next code:

```
const { environment } = require('@rails/webpacker')
const webpack = require("webpack")
environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default']
  }))
module.exports = environment
```

3. In application.html.haml add: `= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' `

4. In application.js add: 

```
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
require("stylesheets/application.scss")
```

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

Don't forget to make a commit before to do the next step: `git commit -am "Commit description."` .

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
* Run the command: `rails generate simple_form:install --bootstrap`.

### Faker gem.

This gem provides fake data in order to see this data in our app.

* Gem: `gem 'faker'`
* Go to our seeds:

```
30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    description: Faker::TvShows::GameOfThrones.quote
  }])
end
```
* Run: `rails db:seed`

For more infrmation, click on this link: https://github.com/faker-ruby/faker

### Devise gem.

#### Installing devise.

This gem provides sign in and sign up features for users.

* Gem: `gem 'devise'`.
* Run: `rails g devise:install`.
* Model user: `rails g devise User`.
* Views: `rails g devise:views`.

In order to restrict actions add: 

* Before action: `before_action :authenticate_user!`

In order to see how many times a User sign up, add **Trackable** and do the next steps.

* Within models/user.rb add: `devise :trackable`.
* Create a new migration: `rails g migration add_trackable_to_devise`.
* The migration should look like: 

```
class AddTrackableToDevise < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet
  end
end
```

* Run: `rails db:migrate`.
* See how many times a user sign up:

```
  .card-footer
    = 'sign_in_count'.humanize
    = user.sign_in_count
    .row
    = 'current_sign_in_at'.humanize
    = user.current_sign_in_at
    .row
    = 'last_sign_in_at'.humanize
    = user.last_sign_in_at
    .row
    = 'current_sign_in_ip'.humanize
    = user.current_sign_in_ip
    .row
    = 'last_sign_in_ip'.humanize
    = user.last_sign_in_ip
```



For more information, click on this link: https://github.com/heartcombo/devise

### Friendly_id gem

Using this gem in order to make friendly the URL of an specific object.

* Gem: `gem 'friendly_id', '~> 5.4.0'`.
* Add a migration: `rails g migration AddSlugToCourses slug:uniq`.
* Run this command: `rails generate friendly_id`.
* Run: `rails db:migrate`.

Go to the Course model (in this example) and add the nex code (you should change the attribute :title according to what you want):

```
extend FriendlyId
friendly_id :title, use: :slugged
```

And in the Course controller, you can modify the method set_Course to:

```
@course = Course.friendly.find(params[:id])
```

Now when you create a new course like the following: `Course.create! title: "Joe Schmoe"`
You can then access the user show page using the URL http://localhost:3000/courses/joe-schmoe.

If you're adding FriendlyId to an existing app and need to generate slugs for existing courses, do this from the console, runner, or add a Rake task: `Course.find_each(&:save)`

For more information, click on this link: https://github.com/norman/friendly_id

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