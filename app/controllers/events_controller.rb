class EventsController < ApplicationController	
	before_action :set_event, :only => [:show, :edit, :update, :destroy]
	
	def index 
		@events = Event.page(params[:page]).per(5)

		respond_to do |format|
			format.html # index.html.erb
			format.xml {render :xml => @events.to_xml}
			format.json {render :json => @events.to_json}
			format.atom{@feed_title = "My event list"} # index.atom.builder
		end
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:notice] = "event was successfully created"
			redirect_to events_url
		else
			render :action => :new
		end
	end
	
	def show
		respond_to do |format|
			format.html {@page_title = @event.name}
			format.xml # show.xml.builder
			format.json {render :json => {id: @event.id, name: @event.name}.to_json}
		end
	end

	def edit
	end

	def update
		if @event.update(event_params)
			flash[:notice] = "event was successfully updated"
			redirect_to :action => :show, :id => @event
		else
			render :action => :edit
		end
		Rails.logger.debug("event: #{@event.inspect}")
	end

	def destroy
		@event.destroy
		flash[:alert] = "event was successfully deleted"

		redirect_to events_url
	end

	def bulk_update
	  ids = Array(params[:ids])
	  events = ids.map{ |i| Event.find_by_id(i) }.compact

	  if params[:commit] == "Publish"
	    events.each{ |e| e.update( :status => "published" ) }
	  elsif params[:commit] == "Delete"
	    events.each{ |e| e.destroy }
	  end

	  redirect_to events_url
	end
	
	private

	def set_event
		@event = Event.find(params[:id])
	end

	def event_params
		params.require(:event).permit(:name, :description, :category_id)
	end
end
