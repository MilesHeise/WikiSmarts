class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :collab_users, through: :collaborations, source: :user

  validates :user, presence: true
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
end
