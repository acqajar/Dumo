Rails.application.routes.draw do
  resources :relationships

  # get 'users/index'

  # get 'users/show'

  get 'users/profile'



  devise_for :users
  resources :users do
    member do
      # gets following and followers for a certain user
      get :following, :followers
    end
  end



resources :pins do
  collection do
    get "search"
  end
    member do
        get 'like', to: 'pins#upvote'
        get 'dislike', to: 'pins#downvote'
      end
  resources :comments
end


root "pins#index"



get 'profile', to: 'users#profile'




resources :relationships, only: [:create, :destroy]

#pins controller and index action

end
