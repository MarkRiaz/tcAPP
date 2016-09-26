Rails.application.routes.draw do
  devise_for :users

  root to: "questions#index"

  resources :questions do
    resources :answers, shallow: true do
      patch :best, on: :member
    end
  end

  resources :attachment, only: :destroy

  root to: "questions#index"
end
