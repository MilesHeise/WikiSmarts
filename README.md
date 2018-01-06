# WikiSmarts

A practice wiki app. Used this project for experience using Pundit gem for authorizations, Devise gem for logins, Redcarpet for markdown-enabled posts, as well as Stripe’s payment API. Also explored join models and the has-many-through relationship.

## Trying it out

* get the gem dependencies by running `bundle install`

* create and seed a sample database to populate the app using `rake db:create` and `rake db:setup`

* run the app with `rails s` and navigating your browser to `localhost:3000`

* the seeds file includes Admin, Premium and Standard member info preconfirmed that you can use to log in. Admin, for example, uses the e-mail `admin@example.com` and all three use the password "helloworld". With admin you can see full view of all posts and have full power including deleting posts. Premium means you can make private posts, and set collaborators who can see those private posts. Standard members can create regular posts and update public ones, while unsigned-in users are read-only. 

* you can sign up on your own and a gem in the testing suite should open your confirmation "e-mail" in a new tab. My Stripe API keys are protected by the Figaro gem and not uploaded to GitHub, so you would need your own hidden Stripe keys file for this feature to work and let you test "pay" to upgrade membership. This means if you sign in under your own name you will not be able to use the upgrade button to go from Standard user to Premium. For this reason I recommend just using the pre-set user logins mentioned above. Also, downgrading membership does not require Stripe access so if you log in under `premium@example.com` you can also downgrade your membership to view the site as a standard member without logging out and back in under `standard@example.com`

