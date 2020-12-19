Rails.application.routes.draw do
  resources :users

  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  post '/send', to: 'send_message#send_messages'
  post '/reply', to: 'reply#reply'
  get '/read', to: 'reply#read'
  get '/list', to: 'list_chat#listchat'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
