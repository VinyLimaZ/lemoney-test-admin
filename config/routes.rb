Rails.application.routes.draw do
  resources :offers, only: %i[new create index destroy]
end
