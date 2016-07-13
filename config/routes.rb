Rails.application.routes.draw do
  root 'welcome#index'
  get '/:summoner_name', to: 'welcome#index'
end
