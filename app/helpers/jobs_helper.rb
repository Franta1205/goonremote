module JobsHelper
  def display_location(location)
    Locations::COUNTRIES.each do |display_name, value|
      return display_name if value == location
    end
    location.humanize
  end
end
