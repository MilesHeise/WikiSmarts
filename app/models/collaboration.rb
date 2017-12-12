class Collaboration < ActiveRecord::Base
  attr_accessor :email
  # message about how this worked?

  belongs_to :user
  belongs_to :wiki

  validates :user_id, presence: true
  validates :wiki_id, presence: true
end
