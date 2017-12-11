class CollaborationsController < ApplicationController
  def new
    @collab = Collaboration.new
  end

  def create
    @collab = Collaboration.new(collab_params)

    if @collab.save
      flash[:notice] = 'Collaborator added.'
      render :new
    else
      flash.now[:alert] = 'There was an error. Please try again.'
      render :new
    end
  end

  private

  def collab_params
    params.require(:collaboration).permit(:user_id, :wiki_id)
  end
end
