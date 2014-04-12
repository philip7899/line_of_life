class Picture < ActiveRecord::Base
	mount_uploader :pic, PicUploader
end
