class Location < ActiveRecord::Base
  attr_accessible :city, :country, :country_code, :end_date, :latitude, 
                  :longitude, :start_date, :street_address

  belongs_to :locatable, polymorphic: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :country, presence: true

  validates :latitude, format: {
             with: /^\s*[-+]?\d+/,
            message: "Invalid latitude/longitude format" 
  }
  validates :longitude, format: { 
            with: /^\s*[-+]?\d+/, 
            message: "Invalid latitude/longitude format" 
  }

  validates :locatable_id, uniqueness: { scope: [:latitude, :longitude, :start_date, :end_date] }
  
  after_validation :geocode

  geocoded_by :full_address
  reverse_geocoded_by :latitude, :longitude

  def full_address
    [street_address, city, country].compact.joing(", ")
  end
end
