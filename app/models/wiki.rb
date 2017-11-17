class Wiki < ActiveRecord::Base
  belongs_to :user

  # default_scope { order('rank DESC') }
  # look into how I can make them alphabetical by title?

  validates :user, presence: true
end
