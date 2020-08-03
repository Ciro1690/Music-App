class AlbumsController <ApplicationController

  def index
    @albums = Album.all
    render :index
  end

  def create
    @album = Album.new(album_params)

    if @album.save
        redirect_to album_url(@album)
    else
        @band = @album.band
        flash.now[:errors] = @album.errors.full_messages
        render :new
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    @album = Album.find_by(id: params[:id])

    if @album.update_attributes(album_params)
        redirect_to album_url(@album)
    else
        render :edit
    end
  end
    def destroy
      @album = Album.find_by(id: params[:id])
      @album.destroy
      redirect_to band_url(@album.band)
    end

    private
    def album_params
        params.require(:album).permit(:name, :year, :band_id, :live)
    end
end