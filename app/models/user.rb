class User < ApplicationRecord
  rolify
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #이름없이 회원가입 방지
  validates :name, presence: true
  
  after_create :default_user
  #self 는 한 유저. user가 생성되면서 권한(role) 설정됨.(newuser(임의의 권한)로 DB에 생성됨)
  def default_user
    self.add_role(:newuser) if self.roles.blank?
  end
  
  #직접 권한 지정을 하는 경우
  # def admin?
  #   self.role == 'admin'
  # end
  
  #controller 상에서 current_user.admin? -> self
end
