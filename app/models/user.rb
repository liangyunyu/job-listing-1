class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs
  has_many :resumes

  def admin?
    is_admin
    # email == 'admin@test.com'
  end

  def is_member_of?(job)
    collected_jobs.include?(job)
  end

  # 加入收藏 #
  # def add_collection!(job)
  #   collected_jobs << job
  # end

  # 移除收藏 #
  # def remove_collection!(job)
  #   collected_jobs.delete(job)
  # end

  def display_name
    if self.name.present?
      self.name
    else
      self.email.split("@").first
    end
  end
end
