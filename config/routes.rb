City::Application.routes.draw do

  namespace :admin do
    resources :users
    resources :sites do
      resources :layouts, :pages, :includes, :articles
    end
  end

  mount Resque::Server.new, :at => "/admin/resque"

  post "admin/login" => "admin/sessions#create"
  get "admin/login" => "admin/sessions#new"
  get "admin/logout" => "admin/sessions#destroy", :as => "admin_logout"

  get "admin" => "admin/sites#index", :as => "admin"

  get "*path" => "application#render_site"
  root :to => "application#render_site"

end
