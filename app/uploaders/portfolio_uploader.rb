class PortfolioUploader < CarrierWave::Uploader::Base
  # Include Cloudinary support if CLOUDINARY_URL is present
  include Cloudinary::CarrierWave if ENV['CLOUDINARY_URL'].present?

  # Storage is configured globally in config/initializers/carrierwave.rb
  # Will use Cloudinary, AWS, or local file storage based on environment variables

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def public_id
    return model.id.to_s if ENV['CLOUDINARY_URL'].present?
    nil
  end

end
