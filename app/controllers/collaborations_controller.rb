class CollaborationsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collab = @wiki.collaborations.new
  end

  def create
    user = User.find_by_email(collab_params[:email])
    wiki = Wiki.find(params[:wiki_id])
    collab = wiki.collaborations.new(user: user)

    if collab.save
      flash[:notice] = 'Collaborator added.'
      redirect_to new_wiki_collaboration_path(wiki)
    else
      flash.now[:alert] = 'There was an error. Please try again.'
      render :new
    end
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collab = Collaboration.find(params[:id])

    if collab.destroy
      flash[:notice] = 'Collaborator removed successfully.'
      redirect_to edit_wiki_path(wiki)
    else
      flash.now[:alert] = 'There was an error removing collaborator.'
      redirect_to edit_wiki_path(wiki)
    end
  end

  private

  def collab_params
    params.require(:collaboration).permit(:email)
  end
end
