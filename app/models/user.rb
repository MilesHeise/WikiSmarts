class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborations
  has_many :collab_wikis, through: :collaborations, source: :wiki

  after_initialize :init

  enum role: %i[standard premium admin]

  # def self.collabable(user, wiki)
  #   where.not(id: wiki.collab_users.pluck(:id) << user.id)
  # end

  def init
    self.role ||= :standard
  end

  def downgrade
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
