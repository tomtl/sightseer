CarrierWave.configure do |config|
  if Rails.env.testing?
    config.storage = :file
    config.enable_processing = false

  else
    config.storage = :aws
    config.aws_bucket = ENV["S3_BUCKET_NAME"]
    config.aws_acl = :"public-read"
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 5

    config.aws_credentials = {
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      config: AWS.config({ s3_endpoint: "s3.amazonaws.com" })
    }
  end
end
