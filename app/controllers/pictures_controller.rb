class PicturesController < ApplicationController

	def new
		@pic = Picture.new
	end

	def create
		@uploaded_pic = Picture.new
		puts 'check0' + @uploaded_pic.shape.to_s
		@uploaded_pic.shape = picture_params[:shape]
		puts 'check1' + @uploaded_pic.shape.to_s
		@uploaded_pic.pic = picture_params[:pic]
		#@uploaded_pic = Picture.new(picture_params)
		puts 'check2' + @uploaded_pic.shape.to_s
		if @uploaded_pic.save
			puts 'picture saved'
		else
			puts 'save did not work'
		end
		@pic = Picture.new
		render 'new'
	end

	private

	def picture_params
		params.require(:picture).permit(:pic, :color, :shape)
	end
end
