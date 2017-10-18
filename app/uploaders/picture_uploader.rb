class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process :main_resize

  def default_url(*args)
    '/images/course/defaultcoursepic.jpg'
  end

  # Create different versions of your uploaded files:
  version :small do
    process :small_resize

    def default_url(*args)
      '/images/course/small_defaultcoursepic.jpg'
    end
  end

  def small_resize
    manipulate! do |img|
      img.format('jpg') do |c|
        c.resize '200x200^'
        c.quality '82'
        c.gravity 'center'
        c.extent '200x200'
      end
      img
    end
  end

  def main_resize
    manipulate! do |img|
      img.format('jpg') do |c|
        c.resize '400x300>'
        c.quality '79'
      end
      img
    end
  end

  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # original_filename # content_type
  # https://github.com/carrierwaveuploader/carrierwave/wiki/how-to:-create-random-and-unique-filenames-for-all-versioned-files
  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-efficiently-converting-image-formats
  def filename
    if original_filename.present?
      extension = 'jpg' #content_type.include?('png') ? 'png' : content_type.include?('gif') ? 'gif' : 'jpg'
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
end
