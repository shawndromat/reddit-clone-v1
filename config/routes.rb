RedditClone::Application.routes.draw do
  root 'subs#index'
  resources :users
  resource :session
  resources :subs
  resources :links do
    resources :comments, only: [:create] do
      resources :comments, only: [:create]
    end

    member do
      post 'upvote'
      post 'downvote'
    end
  end
  resources :comments, only: [:destroy]
end
