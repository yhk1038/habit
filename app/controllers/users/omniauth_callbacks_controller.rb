class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # You should configure your model like this:
    # devise :omniauthable, omniauth_providers: [:twitter]

    # You should also create an action method in this controller like this:
    # def twitter
    # end

    # More info at:
    # https://github.com/plataformatec/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    def self.provides_callback_for(provider)
        class_eval %Q{
            def #{provider}
              env = request.env
              @user = User.find_for_oauth(env["omniauth.auth"], current_user)

              if @user.persisted?
                  sign_in_and_redirect @user, event: :authentication
              else
                  session["devise.#{provider}_data"] = env["omniauth.auth"]
                  redirect_to new_user_registration_url
              end
            end
        }
    end
    [:kakao, :facebook, :google_oauth2].each do |provider|
        provides_callback_for provider
    end
    # provider별로 서로 다른 로그인 경로 설정

    def after_sign_in_path_for(resource)
        auth = request.env['omniauth.auth']
        @identity = Identity.find_for_oauth(auth)
        @user = User.find(current_user.id)
        if @user.persisted?
            if @identity.provider == "kakao"
                edit_user_registration_path
            else
                projects_path
            end
        else
            root_path
        end
    end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
end
