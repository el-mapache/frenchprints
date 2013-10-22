class Person < ActiveRecord::Base
  attr_accessible :bio, :name, :blurb, :role_ids, :locations_attributes
  
  # Associations
  has_many :representations, dependent: :destroy
  has_many :representees, through: :representations, foreign_key: :represented_id
  belongs_to :representative

  has_many :artworks, class_name: "Artwork", foreign_key: :artist_id, dependent: :destroy

  has_and_belongs_to_many :roles, uniq: true, before_add: :validates_role
  accepts_nested_attributes_for :roles

  has_many :locations, as: :locatable, dependent: :destroy
  accepts_nested_attributes_for :locations

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :blurb, length: { maximum: 140 }

  after_create :add_default_events

  class << self
    def all_with_roles
      Person.includes(:roles).all
    end
  end

  # For whatever reason this finder wasnt working by default
  def representative
    Person.find_by_sql(["SELECT `people`.* FROM `people` INNER JOIN `representations` ON `people`.`id` = `representations`.`person_id` WHERE `representations`.`represented_id` = ?", id])
  end

  # Build Associations 
  def add_role name
    roles << Role.where(name: name).first_or_create
    save
  end

  # Add a new representation between dealer and artist
  # TODO/Note: The artist resource is not validated
  def represent(representee, start_date, end_date)
    return errors.add(:base, "Only dealers can represent someone.") unless has_role?("Dealer")
    representations.create(representee: representee, start_date: start_date, end_date: end_date)
  end

  # Params should constitute a valid artwork model
  def add_artwork(params)
    # Philosophy
    return errors.add(:base, "Only artists can produce artwork.") unless has_role?("Artist")
    artworks.create(params)
    save
  end

  # These two methods provide date based searching

  # See all of a dealers representees during a specific timeframe
  def representees_during(from, to)
    representations.where("Date(start_date) >= ? AND DATE(end_date) <= ?", from, to)
  end

  # Who represented a particular artist during a given timeframe
 # def was_represented_during(from, to)
 #   representative.select do |rep|
 #     if rep.represented_id == id && rep.start_date >= from && rep.end_date <= to
 #       rep
 #     end
 #   end.compact!
 # end

  def has_role?(role)
    !roles.where(name: role).empty?
  end

  def birth
    locations.where(event_name: "birth")
  end

  def death
    locations.where(event_name: "death")
  end

  private
  def validates_role(role)
    raise ActiveRecord::Rollback if self.roles.include? role
  end

  # Create a pair of birth and death records
  def add_default_events
    locations.create(event_name: "birth")
    locations.create(event_name: "death")
    save
  end
end

