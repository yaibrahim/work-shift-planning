Rails.application.routes.draw do
  resources :workers
  resources :shifts do
    collection do
      get 'shift_with_workers'
    end
  end

  get '/workers/:id/shifts', to: 'workers#get_shifts', as: 'worker_shifts'
end
