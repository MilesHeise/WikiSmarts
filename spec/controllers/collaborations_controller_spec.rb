require 'rails_helper'

RSpec.describe CollaborationsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, id: 1337) }
  let(:wiki) { create(:wiki) }
  let(:my_collaboration) { create(:collaboration, wiki_id: wiki.id, user_id: user.id) }

  describe 'GET new' do
    it 'returns http success' do
      get :new, wiki_id: wiki.id, user_id: user.id
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      get :new, wiki_id: wiki.id, user_id: user.id
      expect(response).to render_template :new
    end

    it 'instantiates @collab' do
      get :new, wiki_id: wiki.id, user_id: user.id
      expect(assigns(:collab)).not_to be_nil
    end
  end

  describe 'POST create' do
    it 'increases the number of Collaboration by 1' do
      expect do
        post :create,
             wiki_id: wiki.id,
             collaboration: { wiki_id: wiki.id, user: other_user.email }
      end.to change(Collaboration, :count).by(1)
    end

    it 'redirects to the new collab page' do
      post :create, wiki_id: wiki.id, collaboration: { wiki_id: wiki.id, user: other_user.email }
      expect(response).to redirect_to new_wiki_collaboration_path(wiki)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the post' do
      delete :destroy, wiki_id: wiki.id, id: my_collaboration.id
      count = Collaboration.where(id: my_collaboration.id).size
      expect(count).to eq 0
    end

    it 'redirects to edit wiki' do
      delete :destroy, wiki_id: wiki.id, id: my_collaboration.id
      expect(response).to redirect_to edit_wiki_path(wiki.id)
    end
  end
end
