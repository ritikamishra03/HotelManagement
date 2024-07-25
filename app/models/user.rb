
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  ROLES=%w[admin staff customer]

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||='customer'
  end

  def admin?
    role == 'admin'
  end

  def staff?
    role == 'staff'
  end

  def customer?
    role == 'customer'
  end
end

