class Points < Array

  def initialize(array_of_lat_lng=[])
    super(array_of_lat_lng.map{|lat_lng| Geokit::LatLng.new(*lat_lng)})
  end
end