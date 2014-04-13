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

  #version :number_2 do
    process :image_tint_manipulation
  #end

  process :set_content_type
  process :save_content_type_and_size_in_model
  process :save_original_file_name
 
  

  def image_tint_manipulation
    manipulate! do |the_picture|
        puts 'image manipulation'
        puts 'pic here' + @uploaded_pic.to_s
        #the_picture = MiniMagick::Image.open self.path
        #the_picture.resize "640x640"
        the_picture.format "png"
        puts 'model is ' + model.inspect.to_s
        puts 'model shape is ' + model.shape.to_s
        case model.shape
          when 'yellow_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(255,241,0)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/yellow_mask.png"
          when 'cyan_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(90,255,255)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/cyan_mask.png"
        
          when 'pink_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(255,49,125)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/pink_mask.png"

          when 'red_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(219,0,2)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/red_mask.png"

          when 'blue_mask'
            puts 'inside the blue'
            the_picture.combine_options do |c|
              c.fill "rgb(0,4,169)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/blue_mask.png"
        
          when 'green_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(56,255,0)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/green_mask.png"

          when 'purple_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(190,0,216)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/purple_mask.png"

          when 'orange_mask'
            the_picture.combine_options do |c|
              c.fill "rgb(255,106,11)"
              c.tint "120"
            end
            second_image = MiniMagick::Image.open "app/assets/images/orange_mask.png"
        end

        
        puts 'howdy' + second_image.inspect.to_s
        result = the_picture.composite(second_image) do |c|
          c.compose "copy_opacity" # OverCompositeOp # copy second_image onto first_image from (20, 20)
        end
        #model.pic = result
        #result.write "#{model.title}.png"
    end
  end
  def filename 
    "#{SecureRandom.uuid}.png" if original_filename 
  end

  def save_content_type_and_size_in_model
      model.content_type = file.content_type if file.content_type
  end

  def save_original_file_name
    model.title = file.original_filename.titleize if file.original_filename
  end

end
