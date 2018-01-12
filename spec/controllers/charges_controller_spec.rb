require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user) }

  context 'current_user' do
    before do
      sign_in user
      current_user = user
    end

    describe 'GET #new' do
      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'renders the #new view' do
        get :new
        expect(response).to render_template :new
      end

      it 'instantiates @stripe_btn_data' do
        get :new
        expect(assigns(:stripe_btn_data)).not_to be_nil
      end
    end

    describe 'POST create' do
      it 'changes current_user role to premium' do
        post :create, charge: { customer: user.email, amount: 15_00, description: 'Membership', currency: 'usd' }
        user.reload
        expect(user.role).to eql('premium')
      end

      it 'redirects to a new wiki' do
        post :create, charge: { customer: user.email, amount: 15_00, description: 'Membership', currency: 'usd' }
        expect(response).to redirect_to [new_wiki_path]
      end
    end

    describe 'DELETE destroy' do
      it 'triggers downgrade on destroy' do
        expect(user).to receive(:downgrade).at_least(:once)
        delete :destroy
      end

      it 'triggers publicize on destroy' do
        expect(user).to receive(:publicize).at_least(:once)
        delete :destroy
      end

      it 'redirects back' do
        delete :destroy
        expect(response).to redirect_to wikis_path
      end
    end
  end
end

# problem is delete has no reference
