# encoding: utf-8

class ImageUploader <  CarrierWave::Uploader::GoogleDrive 
  include CarrierWave::MiniMagick

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  google_login(Google.email.to_s)
  google_password(Google.password.to_s)

  storage :file if Rails.env == 'development'

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail do
    process :resize_to_fill => [170,170]
  end

  version :small do
    process :resize_to_fill=> [270,203]
  end

  version :standard do
    process :resize_to_fill => [470, 353]
  end

  version :large do
    process :resize_to_fill => [570, 428]
  end

 # def default_url
 #   asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
 # end
end

