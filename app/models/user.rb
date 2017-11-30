class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  after_create :set_standard_role

  enum role: %i[standard premium admin]

  def set_standard_role
    self.role = :standard
    save
  end

  def publicize
    wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end
  end
end
