class TranscriptsController < ApplicationController
  respond_to :html, :xml

  filter_access_to :all

  def index
    @transcripts = (Transcript.are_public + current_user.transcripts).uniq
  end

  def show
    begin
      @transcript = current_user.transcripts.find params[:id]
    rescue ActiveRecord::RecordNotFound
      @transcript = Transcript.are_public.find params[:id]
    end

    @media_item = @transcript.media_item

    # TODO Pick some better filename dynamically
    respond_with @transcript do |format|
      format.html { @transcript }
      format.xml do
        headers["Content-Disposition"] = "attachment; filename=\"eopas.xml\""
        @transcript
      end
    end
  end

  def new
    @transcript = Transcript.new
  end

  def create
    @transcript = current_user.transcripts.build params[:transcript]

    options = Hash.new
    if @transcript.save
      flash[:notice] = 'Transcript was successfully validated and added, please edit automatically discovered values' 
      options[:location] = edit_transcript_path(@transcript)
    end

    respond_with @transcript, options
  end

  def edit
    @transcript = Transcript.find params[:id]
  end

  def update
    @transcript = Transcript.find params[:id]

    if @transcript.update_attributes(params[:transcript])
      flash[:notice] = 'Transcript was successfully updated.'
    end

    respond_with @transcript
  end

  def destroy
    @transcript = current_user.transcripts.find params[:id]

    @transcript.destroy
    flash[:notice] = 'Transcript deleted!'

    redirect_to transcripts_path
  end


  filter_access_to :new_attach_media_item, :require => :new
  def new_attach_media_item
    @transcript = current_user.transcripts.find params[:id]
    @media_items = (MediaItem.are_public + current_user.media_items).uniq
  end

  filter_access_to :create_attach_media_item, :require => :create
  def create_attach_media_item
    @transcript = current_user.transcripts.find params[:transcript_id]
    begin
      @media_item = current_user.media_items.find params[:media_item_id]
    rescue ActiveRecord::RecordNotFound
      @media_item = MediaItem.are_public.find params[:media_item_id]
    end

    @transcript.media_item = @media_item

    flash[:notice] = 'Media Item was added to transcript' if @transcript.save

    respond_with @transcript
  end

end
