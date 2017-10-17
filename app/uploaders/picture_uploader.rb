class PictureUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file

  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # original_filename # content_type
  # https://github.com/carrierwaveuploader/carrierwave/wiki/how-to:-create-random-and-unique-filenames-for-all-versioned-files
  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-efficiently-converting-image-formats
  def filename
    if original_filename.present?
      extension = content_type.include?('png') ? 'png' : content_type.include?('gif') ? 'gif' : 'jpg'
      filename = Digest::MD5.hexdigest(original_filename)
      "#{filename}.#{extension}"
    end
  end

  # dirs splitted by 1000 chunks
  def store_dir
    # "string_id".scan(/.{4}/).first(2).join('/')
    id_partition = ("%03d" % (model.id/100)).scan(/\d{3}/).join('/')
    "system/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partition}"
  end

  def cache_dir
    'system/tmp'
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def content_type_whitelist
    /image\//
  end

  def size_range
    1..1.megabyte
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    '/images/course/default_avatar.png'
  end

  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-efficiently-converting-image-formats
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end
end
