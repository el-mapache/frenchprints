CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.storage = Rails.env.development? ? :file : :fog
#  config.s3_access_policy = :public_read

  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_KEY'],
    :aws_secret_access_key  => ENV['AWS_SECRET'],
    :endpoint               => 'http://s3.amazonaws.com/'
  }

  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public = true

  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end
