Rails.application.routes.draw do
  resources :user_stocks, except: [:show, :edit,:update]
  resources :stocks

  resources :questions
  get '/questions/:id/display_question', to: 'questions#display_question', as: 'display_question'
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'static_pages#home'
	get '/home', to: 'static_pages#home'
	get '/help', to: 'static_pages#help'
	get '/about', to: 'static_pages#about'
	get '/contact', to: 'static_pages#contact'
	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'
	get 'login', to: 'sessions#new'
  get '/search', to: 'users#search'
	post '/login', to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'
	get '/my_portfolio', to: "users#my_portfolio", as: 'my_portfolio'
	resources :users do
		member do
			get :following, :followers
		end
	end
	# Note: show and index is only for the current user
	resources :transactions, only: [:new,:create, :show, :index]

	get '/search_stocks', to: "stocks#search" #stocks controller search action

	resources :relationships, only: [:create, :destroy]

    resources :notifications, only: [:update, :destroy]
    get '/refresh_notifications', to: 'notifications#refresh'
    patch '/mark_all_notifications', to: 'notifications#mark_all'

end
