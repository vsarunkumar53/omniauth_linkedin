# README

1. Add gem file to Gemfile
```

		gem 'devise'
		gem 'omniauth'
		gem 'omniauth-linkedin'
		gem 'omniauth-twitter' 
		gem 'omniauth-facebook'
		gem 'omniauth-google-oauth2'

		```

2. set app key and app secret in config/environments/development.rb

```
		config.linkedin_key = ""
	  config.linkedin_secret = ""

	  config.twitter_key = ""
	  config.twitter_secret = ""

	  config.facebook_key = ""
	  config.facebook_secret = ""

	  config.google_key = ""
	  config.google_secret = "" 

	  ```

3. config omniauth in config/initializers/devise.rb

		```

		 	require 'omniauth-linkedin'

		  config.omniauth :linkedin,  Rails.application.config.linkedin_key, Rails.application.config.linkedin_secret

		  require 'omniauth-twitter'

		  config.omniauth :twitter,  Rails.application.config.twitter_key, Rails.application.config.twitter_secret

		  require 'omniauth-facebook'

		  config.omniauth :facebook,  Rails.application.config.facebook_key, Rails.application.config.facebook_secret, scope: 'public_profile'

		  require 'omniauth-google-oauth2'

		  config.omniauth :google_oauth2,  Rails.application.config.google_key, Rails.application.config.google_secret, scope: 'profile'

		  	```

4. set signin and sign out button in app/views/layouts/application.html.erb

			```
			<% if user_signed_in? %>

	      <%= link_to 'Logout', destroy_user_session_path, method: :delete  %>

	    <% else %>

	      <%= link_to 'Login', new_user_session_path  %>

	      <%= link_to 'Sign up', new_user_registration_path  %>

	      <%= link_to "Sign in with Linkedin", user_linkedin_omniauth_authorize_path %>

	      <%= link_to "Sign in with Twitter", user_twitter_omniauth_authorize_path %>
	      <%= link_to "Sign in with Facebook", user_facebook_omniauth_authorize_path %>
	      <%= link_to "Sign in with Google", user_google_oauth2_omniauth_authorize_path %>
	    <% end %>

	    ```

5. modify app/models/user.rb as

```
		devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

		def self.from_omniauth(auth)
	    user = where("provider = ? AND uid = ?", auth["provider"], auth["uid"]).first || create_from_omniauth(auth)
	  end

	  def self.create_from_omniauth(auth)
	    create do |user|
	      user.provider = auth["provider"]
	      user.uid = auth["uid"]
	      user.email = auth["info"]["email"] if auth["info"]["email"]
	    end
	  end

	  def self.new_with_session(params, session)
	    if session["devise.user_attributes"]
	      new(session["devise.user_attributes"]) do |user|
	        user.attributes = params
	      end
	    else
	      super
	    end
	  end 

```

6. create a file in app/controllers/omniauth_callbacks_controller.rb

```

			class OmniauthCallbacksController < Devise::OmniauthCallbacksController   

			  def linkedin
			    user = User.from_omniauth(request.env["omniauth.auth"])

			    if user.persisted?
			      sign_in_and_redirect user, notice: "Signed in Successfully using Linkedin!"
			    else
			      session["devise.user_attributes"] = user.attributes
			      redirect_to new_user_registration_url, notice: "Please fill this form to complete the registration"
			    end
			  end

			  def twitter
			    user = User.from_omniauth(request.env["omniauth.auth"])

			    if user.persisted?
			      sign_in_and_redirect user, notice: "Signed in Successfully using TWITTER!"
			    else
			      session["devise.user_attributes"] = user.attributes
			      redirect_to new_user_registration_url, notice: "Please fill this form to complete the registration"
			    end
			  end

			  def facebook
			    user = User.from_omniauth(request.env["omniauth.auth"])

			    if user.persisted?
			      sign_in_and_redirect user, notice: "Signed in Successfully using facebook!"
			    else
			      session["devise.user_attributes"] = user.attributes
			      redirect_to new_user_registration_url, notice: "Please fill this form to complete the registration"
			    end
			  end

			  def google_oauth2
			    user = User.from_omniauth(request.env["omniauth.auth"])

			    if user.persisted?
			      sign_in_and_redirect user, notice: "Signed in Successfully using google plus!"
			    else
			      session["devise.user_attributes"] = user.attributes
			      redirect_to new_user_registration_url, notice: "Please fill this form to complete the registration"
			    end
			  end
		 
		end
		
```
