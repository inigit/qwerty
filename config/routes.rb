Qwerty::Engine.routes.draw do
  namespace :admin do
    resources :exports do
      member do
        get :download
      end
    end
  end
end
