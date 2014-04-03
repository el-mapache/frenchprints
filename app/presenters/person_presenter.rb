class PersonPresenter
  attr_reader :name, :blurb, :bio, :birth, :death, :roles
  def initialize(person)
    @person = person
    @name = @person.name
    @blurb = @person.blurb
    @bio = @person.bio
    @birth = has_birth_date
    @death = has_death_date
    @roles = @person.roles
  end


  private
  def has_birth_date
    return "Birth date unkown." if @person.birth.nil?
    @person.birth.start_date.to_s
  end

  def has_death_date
    return "Death date unkown." if @person.death.nil?
    @person.death.start_date.to_s
  end

end

