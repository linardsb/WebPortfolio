class PortfolioUploader < CarrierWave::Uploader::Base

  # Storage is configured globally in config/initializers/carrierwave.rb
  # Will use :file for local storage or :aws if all AWS credentials are present

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
