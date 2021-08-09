Rails.application.routes.draw do
  resources :users, only: %i[create index show]
  resources :chats, only: %i[create index] do
    resources :messages, only: %i[index update show]
  end
end
