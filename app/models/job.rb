class Job < ApplicationRecord
  validates :title, presence: { message: "请填写工作名称" }
  validates :name, presence: { message: "请填写公司或个人名称" }
  validates :content, presence: { message: "请填写工作内容" }
  validates :category, presence: { message: "请选择工作类型" }
  validates :location, presence: { message: "请选择工作地点" }
  # validates :wage_upper_bound, presence: true
  # validates :wage_lower_bound, presence: true
  validates :wage, presence: { message: "请填写报酬" }
  # validates :wage_lower_bound, numericality: { greater_than: 0}
  validates :wage, numericality: { greater_than: 0}
  validates :contact, presence: { message: "请填写联系方式" }

  belongs_to :user
  has_many :resumes

  scope :published, -> {where(is_hidden: false)}
  scope :recent, -> {order('created_at DESC')}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :recent, -> { order('created_at DESC') }
  scope :published, -> { where(is_hidden: false) }
  scope :random5, -> { limit(5).order("RANDOM()") }

  scope :wage1, -> { where('wage <= 5') }
  scope :wage2, -> { where('wage between 5 and 10') }
  scope :wage3, -> { where('wage between 10 and 15') }
  scope :wage4, -> { where('wage between 15 and 25') }
  scope :wage5, -> { where('wage >= 25') }


end
