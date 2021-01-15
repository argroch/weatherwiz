class HomeController < ApplicationController
	include HomeHelper

  before_action :authenticate_user!, except: [:index, :weather_check]


  def index
  	@states = %w(AL AK AR AS AZ CA CO CT DE FL GA GU HI IA ID IL IN KS KY LA MA MD ME MI MN MO MP MS MT NB NC ND NH NJ NM NV NY OH OK OR PA PR RI SC SD TN TX UM UT VA VI VT WA WI WV WY)

    if user_signed_in?
      @locations = Location.where(user_id: current_user.id)
    else
      @locations = Locale.where(user_ip: request.remote_ip)
    	@locations.each do |location|
    		if (DateTime.now.utc - location.created_at) > 300
    			Location.delete(location.id)
          @locations.delete(location.id)
    		end
      end
  	end

    if params[:location_id] != nil
      if user_signed_in?
        @location = Location.find(params[:location_id])
      else
        @location = Locale.find(params[:location_id])
      end
    end
  end

  def weather_check
    if params[:location_id] != nil && user_signed_in?
      location = Location.find(params[:location_id])
    elsif params[:location_id] != nil
      location = Locale.find(params[:location_id])
    else

      if user_signed_in?
        location = Location.create(city: params[:city], state: params[:state], user_id: current_user.id)
      else
        location = Locale.create(city: params[:city], state: params[:state], user_ip: request.remote_ip)
      end

    end

  	weather_results = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{location.city},#{location.state},us&appid=#{ENV['ow_api_key']}")

  	location.update(weather_words: weather_results["weather"][0]["main"], weather_icon: weather_results["weather"][0]["icon"], temperature: kelvin_conversion(weather_results["main"]["temp"]))

    location.save
  	redirect_to root_path(location_id: location.id)
  end

  def log_in
    redirect_to root_path
  end
end
