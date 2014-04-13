class Picture < ActiveRecord::Base

  #after_create :image_tint_manipulation

  before_create :default_name
  
  def default_name
    self.title ||= SecureRandom.uuid
  end

	mount_uploader :pic, PicUploader
end
