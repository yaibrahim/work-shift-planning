Rails.application.routes.draw do
  resources :workers
  resources :shifts

  get '/workers/:id/shifts', to: 'workers#get_shifts', as: 'worker_shifts'
end
