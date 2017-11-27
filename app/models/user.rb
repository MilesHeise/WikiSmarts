class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  after_initialize :set_standard_role

  enum role: %i[standard premium admin]

  def set_standard_role
    self.role ||= :standard
  end
end
