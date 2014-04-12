CarrierWave.configure do |config|
	if Rails.env.development?
		config.storage = :file
	else
		config.storage = :fog
		config.fog_credentials = {
			:provider => 'AWS',
			:aws_access_key_id => ENV['EMAGCOLLAB_AWS_KEY'],
			:aws_secret_access_key => ENV['EMAGCOLLAB_AWS_SECRET_KEY']
		}
		config.fog_directory = ENV['EMAGCOLLAB_BUCKET']
	end
end