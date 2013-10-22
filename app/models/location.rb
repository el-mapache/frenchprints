class Location < ActiveRecord::Base
  attr_accessible :city, :country, :country_code, :end_date, :latitude,
                  :longitude, :start_date, :street_address,
                  :state, :province, :event_name

  belongs_to :locatable, polymorphic: true

  validates :event_name, :start_date, presence: true

  validates :locatable_id, uniqueness: {
    scope: [:latitude, :longitude, :start_date, :end_date, :event_name] 
  }


  #after_validation :check_geocode

  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude

  def full_address
    [street_address, city, country].compact.join(", ")
  end

  private

  # We need a country and street at minimum to geocode
  def check_geocode
    return if street_address.nil? && country.nil?
    geocode
  end
end
