module HomeHelper
	def kelvin_conversion(temp)
    fahrenheit = ((temp - 273.15) * 9)/5 + 32
    return fahrenheit.to_i
  end
end
