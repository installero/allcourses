Rails.application.routes.draw do
  # https://github.com/plataformatec/devise/wiki/How-To:-Disable-user-from-destroying-their-account
  devise_for :users, skip: :registrations, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    resource :registration,
             only: [:new, :create, :edit, :update],
             path: 'users',
             path_names: {new: 'sign_up'},
             controller: 'devise/registrations',
             as: :user_registration
  end

  resources :users, only: [:show, :edit, :update]

  resources :courses do
    resources :reviews, except: [:index, :show]
  end

  root to: 'courses#index'
end
