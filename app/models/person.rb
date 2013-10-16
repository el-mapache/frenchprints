class Person < ActiveRecord::Base
  attr_accessible :bio, :name

  has_many :representations, dependent: :destroy
  has_many :representees, through: :representations, foreign_key: :represented_id,
           readonly: true, conditions: proc { "DATE(#{Date.today}) BETWEEN start_date AND end_date"}
  #
  #has_many :representatives, through: :representations, foreign_key: :person_id,
  #         conditions: proc { "person_id != #{self.id} AND represented_id = #{self.id}" }, readonly: true
  #has_many :inverse_representations, through: :representations
  #has_many :inverse_representatives, through: :inverse_representations, source: :person

  has_many :artworks, class_name: "Artwork", foreign_key: :artist_id, dependent: :destroy

  has_and_belongs_to_many :roles, uniq: true, before_add: :validates_role

  # Validations
  validates :name, presence: true


  def add_role name
    roles << Role.where(name: name).first_or_create
    save
  end

  def represent represented_id
    representations.build(represented_id: represented_id)
  end

  def is_represented_by
    Person.find_by_sql(["SELECT p.* FROM people p INNER JOIN representations r ON p.id = r.person_id WHERE r.represented_id = ?", id])
    #) #? AND DATE(?) BETWEEN start_date AND end_date', id, Date.today)
  end

  def was_represented_by
    representations.where('represented_id = ? AND end_date < ?', id, Date.today)
  end

  def add_artwork params
    return errors.add(:base, "Only artists can produce artwork.") if roles.where(name: "Artist").empty?
    artworks.create(params)
  end

  private
  def validates_role role
    raise ActiveRecord::Rollback if self.roles.include? role
  end

  def has_role? role
    roles.where(name: role).empty?
  end
end

