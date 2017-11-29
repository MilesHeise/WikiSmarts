class WikisController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = authorize Wiki.new(wiki_params)

    if @wiki.save
      redirect_to @wiki, notice: 'Wiki was saved successfully.'
    else
      flash.now[:alert] = 'Error creating wiki. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = authorize Wiki.find(params[:id])

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = 'Wiki was updated.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'Error saving wiki. Please try again.'
      render :edit
    end
   end

  def destroy
    @wiki = authorize Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(%i[title body private user])
  end
end
