require 'geokit'

class Location < ActiveRecord::Base
  belongs_to :page
  
  before_validation :geocode_address
  after_save :remember_address
  
  validates_presence_of :page
  
  validates_inclusion_of :latitude, :in => -90..90
  validates_inclusion_of :longitude, :in => -180..180
  
  def coordinates
    return nil if !valid?
    
    # TODO: minutes and seconds?
    n_or_s = (latitude == 0 ? '' : (latitude > 0 ? ' N' : ' S'))
    e_or_w = (longitude == 0 ? '' : (longitude > 0 ? ' E' : ' W'))

    "#{latitude.abs}#{n_or_s}, #{longitude.abs}#{e_or_w}"
  end
  
protected
  
  def geocode_address
    if address.blank?
      errors.add(:address, "Address cannot be blank")
    elsif new_record? || address_changed?
      # TODO: make choice of geocoder configurable
      geo = Geokit::Geocoders::GoogleGeocoder.geocode(address)
      self.latitude, self.longitude = geo.lat, geo.lng
      errors.add(:address, "Couldn't find address") if !geo.success
    end
  end
  
  # TODO: Radiant 0.7 (i.e., Rails 2.1.2) should make this unnecessary
  def remember_address
    @unchanged_address = self.address
  end
  alias after_initialize remember_address
  
  def address_changed?
    # TODO: Radiant 0.7 (i.e., Rails 2.1.2) should make this unnecessary
    self.address != @unchanged_address
  end
end
