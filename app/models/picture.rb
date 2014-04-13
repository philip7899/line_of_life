class Picture < ActiveRecord::Base

  #after_create :image_tint_manipulation



	mount_uploader :pic, PicUploader
end
