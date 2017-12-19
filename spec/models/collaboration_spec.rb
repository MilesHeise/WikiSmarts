require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki) }
  let(:collaboration) { create(:collaboration) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:wiki_id) }

  describe 'attributes' do
    it 'has a wiki_id and user_id attribute' do
      expect(collaboration).to have_attributes(wiki_id: collaboration.wiki_id, user_id: collaboration.user_id)
    end
  end
end
