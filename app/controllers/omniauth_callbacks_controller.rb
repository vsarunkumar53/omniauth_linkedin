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