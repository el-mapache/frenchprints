class Person < ActiveRecord::Base
  attr_accessible :bio, :name
  
  # Associations
  has_many :representations, dependent: :destroy
  has_many :representees, through: :representations, foreign_key: :represented_id, readonly: true
  has_many :representatives, foreign_key: :represented_id, class_name: "Representation"

  #has_many :inverse_representations, through: :representations, source: :person, foreign_key: :represented_id
  #has_many :inverse_representees, through: :inverse_representations, source: :representative
  #has_many :inverse_representatives, through: :inverse_representations, source: :representee

  has_many :artworks, class_name: "Artwork", foreign_key: :artist_id, dependent: :destroy

  has_and_belongs_to_many :roles, uniq: true, before_add: :validates_role

  # Validations
  validates :name, presence: true, uniqueness: true

  # Build Associations 
  def add_role name
    roles << Role.where(name: name).first_or_create
    save
  end

  # Add a new representation between dealer and artist
  # TODO/Note: The artist resource is not validated
  def represent(represented_id, start_date, end_date)
    return errors.add(:base, "Only dealers can represent someone") if roles.where(name: "Dealer").empty?
    representations.create(represented_id: represented_id, start_date: start_date, end_date: end_date)
  end

  # Params should constitute a valid artwork model
  # This should maybe be moved to the 
  def add_artwork(params)
    # Philosophy
    return errors.add(:base, "Only artists can produce artwork.") if roles.where(name: "Artist").empty?
    artworks.create(params)
  end

  # These two methods provide date based searching
  def representees_during(from, to)
    representations.where("Date(start_date) >= ? AND DATE(end_date) <= ?", from, to)
  end
  
  # Is there a way to combine these into one rad method?
  # Some kind of partial application?
  #
  # More importantly, this method tells who represented a particular artist during a given timeframe
  def was_represented_during(from, to)
    representatives.where('represented_id = ? AND DATE(start_date) >= ? AND DATE(end_date) <= ?', id, from, to)
  end

  private
  def validates_role role
    raise ActiveRecord::Rollback if self.roles.include? role
  end

  def has_role? role
    roles.where(name: role).empty?
  end
end

