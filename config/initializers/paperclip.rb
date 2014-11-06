unless Rails.env.test?
  Paperclip::Attachment.default_options.merge!(
    {
      storage: :s3,
      s3_credentials: {
        bucket: ENV["s3_bucket"],
        access_key_id: ENV["s3_key_id"],
        secret_access_key: ENV["s3_access_key"],
      },
      styles: {
        medium: "300x300>",
        thumb: "100x100>"
      },
      path: ":rails_env/:class/:id/:hash-:style.:extension",
      hash_secret: "wortham-is-the-man",
      url: ":s3_domain_url",
      default_url: "http://fillmurray.com/252/158"
    }
  )
end

# http://stackoverflow.com/a/26285035
