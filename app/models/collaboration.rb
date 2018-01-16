class Collaboration < ActiveRecord::Base
  attr_accessor :email

  belongs_to :user
  belongs_to :wiki

  validates :user_id, presence: true
  validates :wiki_id, presence: true
end
