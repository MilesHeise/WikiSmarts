# WikiSmarts

A practice wiki app. Used this project for experience using Pundit gem for authorizations, Devise gem for logins, Redcarpet for markdown-enabled posts, as well as Stripe’s payment API. Also explored join models and the has-many-through relationship.

## Trying it out

The seeds file includes Admin and Member info preconfirmed that you can use to log in, or you can sign up on your own and a gem in the testing suite will open your confirmation "email" in a new tab. My Stripe API keys are protected by the Figaro gem and not uploaded to GitHub, so you would need your own hidden Stripe keys file for this to work.

