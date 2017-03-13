Rails.application.routes.draw do
  match 'shorten', to: 'links#shorten', via: :post
  match ':shorten_path+', to: 'stats#show', via: :get
  match ':shorten_path', to: 'redirects#redirect_permanently', via: :get

  root 'links#index'
end
