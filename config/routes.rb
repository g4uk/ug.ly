Rails.application.routes.draw do
  match 'shorten', to: 'links#shorten', via: :post

  root 'page#index'
end
