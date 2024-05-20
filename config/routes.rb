Rails.application.routes.draw do
  resources :sections, except: [:edit, :update] do
    resources :student_sections, only: [:new, :edit, :create, :destroy], shallow: true
  end
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects, :classrooms, :students
  get 'students/:id/download', to: 'students#download', as: 'students_download'
  root to: 'subjects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
