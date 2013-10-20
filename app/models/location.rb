class Location < ActiveRecord::Base
  attr_accessible :city, :country, :country_code, :end_date, :latitude,
                  :longitude, :start_date, :street_address,
                  :state, :province

  has_many :location_events

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :country, presence: true

  #validates :locatable_id, uniqueness: { scope: [:latitude, :longitude, :start_date, :end_date] }
  
  after_validation :geocode

  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude

  def full_address
    [street_address, city, country].compact.join(", ")
  end
end
