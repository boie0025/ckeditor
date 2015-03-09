Ckeditor::Engine.routes.draw do
  resources :pictures, :only => [:index, :create, :destroy]
  resources :attachment_files, :only => [:index, :create, :destroy]
  resources :folders
  resources :public_resources, path: "/downloads"
  resources :public_resources
  resources :albums do
    resources :content_assets, only: [:create, :destroy], controller: 'albums_content_assets'
  end
end
