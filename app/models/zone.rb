class Zone < ActiveRecord::Base
  serialize :boundaries, Points

  acts_as_mappable :default_units => :miles,
                 :default_formula => :sphere,
                 :distance_field_name => :distance,
                 :lat_column_name => :latitude,
                 :lng_column_name => :longitude

  def boundary
    Geokit::Polygon.new(boundaries)
  end
end
