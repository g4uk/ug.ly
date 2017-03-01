Rails.application.routes.draw do
  resources :links
  root 'page#index'
end
