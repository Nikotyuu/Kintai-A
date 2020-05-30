Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get 'users/kyoten', to: 'users#kyoten'
  get 'users/syukkin', to: 'users#syukkin'
  get 'users/kintaihensyuu', to: 'users#kintaihensyuu'
  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  

  

  resources :users do
    collection { post :import }
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      patch 'update_user_info'
      get 'attendances_edit_log'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
    end
    
    resources :attendances do
      member do
       patch 'update'
       get 'edit_overtime'
       patch 'update_overtime'
       get 'edit_approval'
       patch 'update_approval'
       get 'edit_change'
       patch 'update_change'
       get 'edit_request_overtime'
       patch 'update_request_overtime'
      end
    end
  end
end