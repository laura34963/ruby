Rails::application.routes.draw do
	resources :events do
		collection do
			post :bulk_update
		end
		resources :attendees, :controller => 'event_attendees'
		resource :location, :controller => 'event_locations'
	end
	#get "welcome/say_hello" => "welcome#say"
	#get "welcome" => "welcome#index"
	#root :to => "welcome#index"
	#match ':controller(/:action(/:id(.:format)))', :via => :all
end
