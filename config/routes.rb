Rails.application.routes.draw do
    # App root
    root 'site#randing'

    # User sessions
    devise_for :users, controllers: {
        sessions: 'users/sessions'
    }

    # Resources
    scope module: 'habits' do
        resources :projects, path: 'habits' do
            resources :ddays
        end
    end

end
