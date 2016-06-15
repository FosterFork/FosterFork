Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users,
             controllers: {
               omniauth_callbacks: "users/omniauth_callbacks",
               registrations:      "users/registrations",
               sessions:           "users/sessions"
             }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#root'

  get '/map',     to: 'pages#map'

  get '/about',         to: 'text_blocks#about'
  get '/instructions',  to: 'text_blocks#instructions'
  get '/contact',       to: 'text_blocks#contact'
  get '/imprint',       to: 'text_blocks#imprint'
  get '/terms',         to: 'text_blocks#terms'

  get 'profile/projects', to: 'profile#projects'

  resources :users,      only: [ :show ]
  resources :categories, only: [ :show ]

  resources :projects do
    resources :abuse_reports,  only: [ :create, :new ]
    resources :inquiries,      only: [ :create, :new ]
    resources :images,         only: [ :create, :destroy ]
    resources :messages,       only: [ :create, :destroy ] do
      resources :comments,     only: [ :create, :destroy ]
    end

    resources :participations, only: [ :create, :destroy ] do
      get :leave
    end

    get  'popup_content'
    post 'new_secret'
  end

end
