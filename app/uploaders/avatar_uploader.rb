class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include LetterAvatar::AvatarHelper

  SIZES = {full: 300, medium: 200, thumb: 25}

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    letter_avatar_url(model.name, SIZES[version_name])
  end

  def scale(width, height)
    process scale: [SIZES[:full], SIZES[:full]]
  end

  version :medium do
    process resize_to_fill: [SIZES[:medium], SIZES[:medium]]
  end

  version :thumb do
    process resize_to_fill: [SIZES[:thumb], SIZES[:thumb]]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
