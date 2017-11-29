class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('title ASC') }
  # this seems to do alphabet wrong (a scanner before absalom) so fix alpha

  validates :user, presence: true
end
