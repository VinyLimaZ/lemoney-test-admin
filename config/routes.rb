Rails.application.routes.draw do
  resources :offers, only: %i[new create index destroy edit update] do
    member do
      post '/toggle_state', to: 'offers#toggle_state'
    end
  end
end
