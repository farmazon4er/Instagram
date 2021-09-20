class ImageUploader < Shrine
  plugin :default_url
  plugin :validation_helpers

  Attacher.default_url do |**options|
    "/placeholders/missing.jpg"
  end

  Attacher.validate do
    validate_extension %w[jpg jpeg png webp]
  end

end



