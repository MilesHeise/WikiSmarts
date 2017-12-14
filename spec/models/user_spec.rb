require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to have_many(:collaborations) }
  it { is_expected.to have_many(:collab_wikis) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe 'attributes' do
    it 'should have email attribute' do
      expect(user).to have_attributes(email: user.email)
    end

    it 'responds to role' do
      expect(user).to respond_to(:role)
    end

    it 'responds to admin?' do
      expect(user).to respond_to(:admin?)
    end

    it 'responds to standard?' do
      expect(user).to respond_to(:member?)
    end

    it 'responds to premium?' do
      expect(user).to respond_to(:premium?)
    end
  end

  describe 'roles' do
    it 'is standard by default' do
      expect(user.role).to eql('standard')
    end

    context 'standard user' do
      it 'returns true for #standard?' do
        expect(user.standard?).to be_truthy
      end

      it 'returns false for #admin?' do
        expect(user.admin?).to be_falsey
      end
    end

    context 'admin user' do
      before do
        user.admin!
      end

      it 'returns false for #standard?' do
        expect(user.standard?).to be_falsey
      end

      it 'returns true for #admin?' do
        expect(user.admin?).to be_truthy
      end
    end

    context 'premium user' do
      before do
        user.premium!
      end

      it 'returns false for #standard?' do
        expect(user.standard?).to be_falsey
      end

      it 'returns true for #premium?' do
        expect(user.premium?).to be_truthy
      end
    end
  end

  describe 'invalid user' do
    let(:user_with_invalid_email) { build(:user, email: '') }

    it 'should be an invalid user due to blank email' do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe 'set_standard_role callback' do
    it 'triggers set_standard_role on create' do
      expect(user).to receive(:set_standard_role).at_least(:once)
      user.create!
    end
  end

  describe '.set_standard_role' do
    before do
      user.premium!
    end

    it 'returns false for #standard?' do
      expect(user.standard?).to be_falsey
    end

    it 'returns true for #premium?' do
      expect(user.premium?).to be_truthy
    end

    before do
      user.set_standard_role!
    end

    it 'returns false for #premium?' do
      expect(user.premium?).to be_falsey
    end

    it 'returns true for #standard?' do
      expect(user.standard?).to be_truthy
    end
  end

  describe '.publicize' do
    let(:wiki) { create(:wiki, user: user, private: true) }

    it 'returns true for #private?' do
      expect(wiki.private?).to be_truthy
    end

    before do
      user.publicize!
    end

    it 'returns false for #private?' do
      expect(wiki.private?).to be_falsey
    end
  end
end
