Rails.application.routes.draw do
    # App root
    root 'site#randing'

    # User sessions
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: 'users/omniauth_callbacks'
    }
    devise_scope :user do
        namespace :users do
            get "/:id", to: 'sessions#show', as: 'profile'
        end
        match "/auth/kakao/callback(.:format)", to: 'users/omniauth_callbacks#kakao', via: [:get, :post]
    end

    # Resources
    scope module: 'habits' do
        resources :projects, path: 'habits' do
            resources :ddays
        end
    end

end
