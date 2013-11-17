module HasMedia
  extend ActiveSupport::Concern

  module ClassMethods
    def has_media
      has_many :media, as: :imagable, dependent: :destroy
      accepts_nested_attributes_for :media, reject_if: :all_blank
      attr_accessible :media_attributes
    end
  end
end

ActiveRecord::Base.send(:include, HasMedia)
