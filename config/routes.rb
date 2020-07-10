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
      get 'attendances/one_month_apply'
      patch 'attendances/update_one_month_apply'
      patch 'attendances/confirmation_one_month_apply'
      get 'attendances/edit_overtime_work_apply'
      patch 'attendances/update_overtime_work_apply'
      get 'attendances/recive_overtime_work_apply'
      patch 'attendances/confirmation_overtime_work_apply'
      get 'attendances/recive_change_attendance_apply'
      patch 'attendances/confirmation_change_attendance_apply'
      get 'attendances/edit_log'
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances_edit_log'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
    end
    
    resources :attendances, only: :update
  end
    
    resources :bases do 
      member do
        get 'edit_basic_info'
        patch 'update_basic_info'
      end
    end
end