CarrierWave.configure do |config|
  # Priority: Cloudinary > AWS > Local File Storage

  # Option 1: Cloudinary is configured via uploader include (PortfolioUploader)
  # No config.storage needed - Cloudinary gem handles it automatically

  # Option 2: AWS S3 (if all AWS credentials are present and Cloudinary not configured)
  if ENV['CLOUDINARY_URL'].blank? &&
     ENV['S3_BUCKET_NAME'].present? &&
     ENV['AWS_ACCESS_KEY_ID'].present? &&
     ENV['AWS_SECRET_ACCESS_KEY'].present? &&
     ENV['AWS_REGION'].present?
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
    config.aws_acl    = 'public-read'
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }

    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region:            ENV.fetch('AWS_REGION')
    }

  # Option 3: Local file storage (fallback, ephemeral on free hosting)
  elsif ENV['CLOUDINARY_URL'].blank?
    config.storage = :file
    config.enable_processing = false if Rails.env.test?
  end
end