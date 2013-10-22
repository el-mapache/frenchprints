namespace :roles do
  desc "Set up roles in the database"
  task initial: :environment do
    roles = %w(artist writer dealer editor publisher exhibitor)

    roles.each do |role|
      r = Role.where(name: role.capitalize).first_or_create
      r.save!
    end
  end
end
