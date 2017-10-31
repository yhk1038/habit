Rails.application.routes.draw do
    # App root
    root 'site#randing'

    # User sessions
    devise_for :users, controllers: {
        sessions: 'users/sessions'
    }
    devise_scope :user do
        namespace :users do
            get "/:id", to: 'sessions#show', as: 'profile'
        end
    end
    #get 'users/:id', to: 'users/sessions#show', as: 'user_profile'

    # Resources
    scope module: 'habits' do
        resources :projects, path: 'habits' do
            resources :ddays
        end
    end

end
