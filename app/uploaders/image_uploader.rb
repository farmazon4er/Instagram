require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :default_url
  plugin :validation_helpers
  plugin :derivatives, create_on_promote: true


  Attacher.default_url do |**options|
    "/placeholders/avatar.jpg"

  end

  Attacher.validate do
    validate_extension %w[jpg jpeg png webp]
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large:  magick.resize_to_limit!(800, 800),
      medium: magick.resize_to_limit!(350, 350),
      small:  magick.resize_to_limit!(150, 150),
    }
  end

end



