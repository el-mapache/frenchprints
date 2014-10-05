class Person < ActiveRecord::Base
  attr_accessible :bio, :name, :blurb, :role_ids,
                  :locations_attributes, :sex,
                  :representations_attributes

  # Associations
  has_many :representations, dependent: :destroy
  has_many :representees, through: :representations, foreign_key: :represented_id
  belongs_to :representative

  has_many :artworks, class_name: "Artwork", foreign_key: :artist_id, dependent: :destroy

  has_and_belongs_to_many :roles, uniq: true, before_add: :validates_role

  has_many :locations, as: :locatable, dependent: :destroy

  has_many :authors_articles, dependent: :destroy
  has_many :articles, through: :authors_articles

  has_many :exhibitions_artists
  has_many :exhibitions, through: :exhibitions_artists

  has_many :galleries
  has_many :ownerships

  # ActiveRecord extension
  has_media

  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :locations, reject_if: :all_blank
  accepts_nested_attributes_for :representations, reject_if: :all_blank

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :blurb, length: { maximum: 140 }
  validates :sex, format: {
    with: /(M|F|U|O)/,
    message: "Invalid gender assignment."
  }

  class << self
    def all_with_roles
      Person.includes(:roles).all
    end

    def all_with_role(role)
      Person.joins(:roles).where("roles.name = ?", role)
    end
  end

  def sex_from_code
    case sex
      when "M"
        "Male"
      when "F"
        "Female"
      when "U"
        "Unknown"
      when "O"
        "Other"
    end
  end

  # For whatever reason this finder wasnt working by default
  def representative
    Person.find_by_sql([
      "SELECT p.* FROM people as p INNER JOIN representations as r ON p.id = r.person_id WHERE r.represented_id = ?", id
    ])
  end

  # Build Associations
  def add_role name
    roles << Role.where(name: name).first_or_create
    save
  end

  def all_roles
    roles.map { |role| role.name }
  end

  # Add a new representation between dealer and artist
  # TODO/Note: The artist resource is not validated
  def represent(representee, start_date, end_date)
    return errors.add(:base, "Only dealers can represent someone.") unless has_role?("Dealer")

    rep = representations.create(represented_id: representee, start_date: start_date, end_date: end_date)
    save
    rep
  end

  # Params should constitute a valid artwork model
  def add_artwork(params)
    # Philosophy
    return errors.add(:base, "Only artists can produce artwork.") unless has_role?("Artist")

    artworks.create(params)
    save
  end

  # This method provides date based searching

  # See all of a dealer's representees during a specific timeframe
  def representees_during(from, to)
    representations.where("(start_date, end_date) OVERLAPS (?::DATE, ?::DATE)", from, to)
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
    locations.where(event_name: "birth").first
  end

  def death
    locations.where(event_name: "death").first
  end

  private
  def validates_role(role)
    raise ActiveRecord::Rollback if self.roles.include? role
  end
end

