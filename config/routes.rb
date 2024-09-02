Rails.application.routes.draw do
  get    'csv_upload'          => 'csv#index'
  post   'csv_upload'          => 'csv#create'
end
