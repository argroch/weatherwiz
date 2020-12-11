class HomeController < ApplicationController
	include HomeHelper

  def index
  	@states = %w(AL AK AR AS AZ CA CO CT DE FL GA GU HI IA ID IL IN KS KY LA MA MD ME MI MN MO MP MS MT NB NC ND NH NJ NM NV NY OH OK OR PA PR RI SC SD TN TX UM UT VA VI VT WA WI WV WY)

  	@locations = []
  	Location.all.each do |location|
  		if (DateTime.now.utc - location.created_at) > 300
  			Location.delete(location.id)
  		end
  		if location.user_ip == request.remote_ip
  			@locations.push(location)
  		end
  	end
  end

  def weather_check
  	location = Location.new
  	location.update(city: params[:city], state: params[:state], user_ip: request.remote_ip)

  	weather_results = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=#{location.city},#{location.state},us&appid=#{ENV['ow_api_key']}")

  	location.update(weather_words: weather_results["weather"][0]["main"], weather_icon: weather_results["weather"][0]["icon"], temperature: kelvin_conversion(weather_results["main"]["temp"]))

  	redirect_to root_path
  end
end
