City::Application.routes.draw do

  namespace :admin do
    resources :users
    resources :sites do
      resources :layouts, :pages, :includes, :articles
    end
  end

  mount Resque::Server.new, :at => "/admin/resque"

  post "admin/login" => "admin/sessions#create", :as => "admin_login"
  get "admin/login" => "admin/sessions#new", :as => "admin_login"
  match "admin/logout" => "admin/sessions#destroy", :as => "admin_logout"

  match "admin" => "admin/sites#index", :as => "admin"

  match "*path" => "application#render_site"
  root :to => "application#render_site"

end
