Rails.application.routes.draw do
  match 'test'  , to: 'api#test'  , via: :all
  match 'random', to: 'api#random', via: :all
end
