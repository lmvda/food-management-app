Rails.application.routes.draw do
  
  resources :foods
  resources :home

  resources :foods do
    collection do
      get 'sort_by_cal_ASC'
      get 'sort_by_cal_DESC'
  end
  end


  root to: 'home#welcome'

  get 'foods/:id' => 'foods#show'
  post 'foods/:id' => 'foods#show'

  get '/about' => 'home#about'

end