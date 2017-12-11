class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :collab_users, through: :collaborations, source: :user

  default_scope { order('title ASC') }
  # this seems to do alphabet wrong (a scanner before absalom) so fix alpha

  validates :user, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  # do I actually need this part?
  def user_ids
    collab_users.pluck(:id)
  end
end
