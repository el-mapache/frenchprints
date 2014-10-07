# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version(:thumb) do
    process(resize_to_fit: [160, 160])
  end
 
  def landscape_or_portrait
    img = Magick::Image.read(current_path)
    width = img[0].columns
    height = img[0].rows
    if width > height
      #original is landscape
      resize_to_fill(738, 492)
    else
      # original is portrait
      resize_to_fit(738, 492)
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
end
