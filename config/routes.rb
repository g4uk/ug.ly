Rails.application.routes.draw do
  match 'shorten', to: 'links#shorten', via: :post
  match ':shorten_path', to: 'links#redirect_permanently', via: :get

  root 'page#index'
end
