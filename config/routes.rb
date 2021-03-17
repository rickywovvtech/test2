Rails.application.routes.draw do
  resources :students
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 namespace 'api' do
  constraints format: :json do
    post 'soduku/create' => 'soduku#create'
    post 'sodsec/create' => 'sodsec/create'
    post 'mongo/tes' => 'soduku#mongo'
  end
 end
end
