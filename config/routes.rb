City::Application.routes.draw do

  namespace :admin do
    resources :sites do
      resources :layouts, :pages, :includes
    end
  end

  match "admin" => "admin/sites#index", :as => "admin"

  match "*path" => "application#render_site"
  root :to => "application#render_site"

end
