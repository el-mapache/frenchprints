CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'xxx',
    :aws_secret_access_key  => 'yyy',
    :region                 => 'us-west-2'
    #:host                   => 's3.example.com',             # optional, defaults to nil
    #:endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }

  config.fog_directory  = 'french-prints-development'

  config.storage = Rails.env.development? ? :file : :fog
  #config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
end
