Rails.application.routes.draw do

    # App root
    root 'site#randing'

    # User sessions
    devise_for :users, controllers: {
        sessions: 'users/sessions'
    }


end
