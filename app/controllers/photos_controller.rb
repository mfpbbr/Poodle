class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
 
  def index
    @photos = Photo.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end

  
  def show
  end

  
  def new
    @photo = current_user.photos.build
  end

  
  def edit
  end

  
  def create
    @photo = current_user.photos.build(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
    
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def correct_user
      @photo = current_user.photos.find_by(id: params[:id])
      redirect_to photos_path if @photo.nil?
    end

    def photo_params
      params.require(:photo).permit(:description, :image)
    end
end
