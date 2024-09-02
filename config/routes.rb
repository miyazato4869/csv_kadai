Rails.application.routes.draw do
  get "/"=> "csv#index"
  post "/data" =>"csv#data"
end
