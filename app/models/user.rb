class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :resumes

  def admin?
    is_admin
    # email == 'admin@test.com'
  end

  def display_name
    if self.name.present?
      self.name
    else
      self.email.split("@").first
    end
  end
end
