# encoding: utf-8

class PicUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  # Choose what kind of storage to use for this uploader:
  #storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  process :resize_to_fill => [640, 640]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def extension_white_list
     %w(jpg jpeg gif png)
  end

  def fog_public
    false
  end



  process :set_content_type
  process :save_content_type_and_size_in_model
  process :save_original_file_name
 
  process :image_tint_manipulation

  def image_tint_manipulation
    puts 'image manipulation'
    the_picture = MiniMagick::Image.open self.path
    #the_picture.resize "640x640"
    the_picture.format "png"
    the_picture.combine_options do |c|
      c.fill "rgb(90,255,255)"
      c.tint "120"
    end

    second_image = MiniMagick::Image.open "app/assets/images/cyan_mask.png"
    puts 'howdy' + second_image.inspect.to_s
    result = the_picture.composite(second_image) do |c|
      c.compose "copy_opacity" # OverCompositeOp # copy second_image onto first_image from (20, 20)
    end

    result.write "#{model.title}.png"
  end


  def save_content_type_and_size_in_model
      model.content_type = file.content_type if file.content_type
  end

  def save_original_file_name
    model.title = file.original_filename if file.original_filename
  end

end
