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

### Trackable users.

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

### Confirmable users.

In order to confirm an email address, do the next:

* Within models/user.rb add: `devise :confirmable`.
* Create a new migration: `rails g migration add_confirmable_to_devise`.
* The migration should look like: 

```
class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    add_index :users, :confirmation_token, unique: true
    User.update_all confirmed_at: DateTime.now
  end
end
```

* Run: `rails db:migrate`.

If you want to see if a user has confirmed its email account, add:

```
Confirmed email?
    - if user.confirmed_at.present?
      .badge.badge-success Yes
    - else
      .badge.badge-danger No
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

### Racker gem.

This gem allowsyou to build a search bar rapidly.
In order to use this gem, following the nexts steps: 

* Gem: `gem 'ransack'`.

Within your controllers file, add: 

```
    def index
        @courses = Course.all
        @q = Course.ransack(params[:q])
        @courses_ransack = @q.result(distinct: true)
    end
```

Within your courses index, add:

```
<%= search_form_for @q do |f| %>

  # Search if an associated articles.title starts with...
  <%= f.label :title_cont %>
  <%= f.search_field :title_cont %>

  <%= f.submit %>
<% end %>
<br>
<%= link_to "Refresh", courses_path %>
<br>

<% if params[:q].present? %>
<h2>Results</h2>
<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Body</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @courses_ransack.each do |course| %>
      <tr>
        <td><%= course.title %></td>
        <td><%= course.body %></td>
        <td><%= link_to 'Show', course %></td>
        <td><%= link_to 'Edit', edit_course_path(course) %></td>
        <td><%= link_to 'Destroy', course, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>
<% end %>
```

### Racker gem.

This gem allowsyou to build a search bar rapidly.
In order to use this gem, following the nexts steps: 

* Gem: `gem 'ransack'`.

Within your controllers file, add: 

```
    def index
        @courses = Course.all
        @q = Course.ransack(params[:q])
        @courses_ransack = @q.result(distinct: true)
    end
```

Within your courses index, add:

```
<%= search_form_for @q do |f| %>

  # Search if an associated articles.title starts with...
  <%= f.label :title_cont %>
  <%= f.search_field :title_cont %>

  <%= f.submit %>
<% end %>
<br>
<%= link_to "Refresh", courses_path %>
<br>

<% if params[:q].present? %>
<h2>Results</h2>
<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Body</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @courses_ransack.each do |course| %>
      <tr>
        <td><%= course.title %></td>
        <td><%= course.body %></td>
        <td><%= link_to 'Show', course %></td>
        <td><%= link_to 'Edit', edit_course_path(course) %></td>
        <td><%= link_to 'Destroy', course, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>
<% end %>
```
### Rolify gem.

This gem will provide you roles to your users.

1. Gem: `gem "rolify"`.
2. Run: `rails g rolify Role User`.
3. User.rb model file: 

```
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify

end
```

4. Run: `rails db:migrate`.
5. In the rails console: `User.first.add_role :admin`.
6. To check user's role: `User.first.has_role? :admin`.
7. We can a method if the user didn't select a role:

```
after_create :assign_default_role

  def assign_default_role
    self.add_role(:moderator) if self.roles.blank?
  end
```

8. In order to the user's roles, you can add this to your view:

```
<% user.roles.each do |role| %>
  <%= role.name >
<% end %>
```

### Pundit gem.

Use this gem in order to set authorizations.

1. Gem: `gem "pundit"`.
2. In application controller add: `include Pundit::Authorization`.
3. Run: `rails g pundit:install`.
4. Go to application controller and add:

```
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
```

5. Run this command: `rails g pundit:policy course`.
6. In course_policy.rb you can add the authorizations:

```
  def edit?
    @user.has_role?:admin
  end
```

7. In course controller, you should add:

```
  def edit
    authorize @course
  end
```

If you want to add validations wetween users:

1. Run this command: `rails g pundit:policy user`.
2. Add thr next code in your user_policy.rb

```
  def edit?
    @user.has_role?:admins
  end
```

In order to hide actions links, you should add: `if policy(course).edit?`.

If you want to see if a user is curretnly logged in:

1. In application_controller.rb add:

```
after_action :user_activity

private: 

  def user_activity
    current_user.try :touch
  end
```

2. In user.rb add:

```
  def online?
    updated_at > 2.minutes.ago
  end
```

3. In the index.html file, you can see that parameter using: `user.online?`

### Exception Notification gem.

This gem will allow you to send an email with all the information about errors in production:

1. Gem: `gem 'exception_notification'`.
2. Add the next code in enviroments"production.rb: 

```
Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    email_prefix: '[PREFIX] ',
    sender_address: %{"School App" <support@schoolapp.herokuapp.com>},
    exception_recipients: %w{ortiz.mata.jorge@gmail.com}
  }
```

### Will Paginate gem.

This gem will allow you see an specific amount of objects in the index.

1. Gem: `gem 'will_paginate', '~> 3.1'`.
2. In your controller, add:

```
  def index
    # @articles = Article.all <-- This was removed in order to include pagination functionality.
    @articles = Article.paginate(page: params[:page], per_page: 3) # <-- Pagination cinfiguration. 3 is the amount of objects displayed in the views.
  end
```

3. In the index view, you should add:

```
<div>
    <%= will_paginate @articles %>
</div>
```

### Pagy gem.

This gem will allow you see an specific amount of objects in the index.

1. Gem: `gem 'pagy'`.
2. Create a file in config/intializres/pagy.rb and the code in this link: https://raw.githubusercontent.com/ddnexus/pagy/master/lib/config/pagy.rb
3. In application_controller add: `include Pagy::Backend`.
4. I this example, we want to paginate our courses, so:

```
def index
  @pagy, @courses = pagy(Course.all)
end
```

5. In application_helper add : `include Pagy::Frontend`.
6. Uncomment these lines in order to declare how many objects will be displayed in your view and add styling.

```
Pagy::DEFAULT[:items]  = 2     
require 'pagy/extras/bootstrap'
```

7. In your index view, you can add the links in order to change between objects.

```
<%== pagy_nav(@pagy) %>
<%== pagy_bootstrap_nav(@pagy) %>
<%== pagy_bootstrap_nav_js(@pagy) %>
<%== pagy_bootstrap_combo_nav_js(@pagy) %>
```


For more information, you can visit these links:

* https://github.com/ddnexus/pagy
* https://ddnexus.github.io/pagy/extras/bootstrap#gsc.tab=0
* https://raw.githubusercontent.com/ddnexus/pagy/master/lib/config/pagy.rb

## Scopes.

Using scopes in order to add programming logic. This scopes will be called from the controller, example:

In controllers/courses.rb:

```
  @courses_latest = Course.latest
```

In model/user.rb

```
  scope :latest, -> { limit(3).order(created_at: :desc) }
```

## Dependent Destroys.

If youo have a course model where users leave reviews and, if a user cancel its account and you 
want to keep his a review, in the user model, you should add: `dependent: :nullify`.

## Chartkick gem. 

This gem will allow you to draw charts in your application.

1. Gem: `gem "chartkick"`.

For more information, check this link: https://chartkick.com/ 

## Groupdate gem.

1. Gem: `gem "groupdate"`.

For more informaiton, check this link: https://github.com/ankane/groupdate

## Cleaning routes.

You can clean your routes by addinf :namespace as a group:

```
namespace :charts do
    get 'users_per_day'
    get 'enrollments_per_day'
    get 'course_popularity'
    get 'money_makers'
  end
  #get 'charts/users_per_day', to: 'charts#users_per_day'
  #get 'charts/enrollments_per_day', to: 'charts#enrollments_per_day'
  #get 'charts/course_popularity', to: 'charts#course_popularity'
  #get 'charts/money_makers', to: 'charts#money_makers'
```

All these routes belong to **charts_controller.rb**.

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
