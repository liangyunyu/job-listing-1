class Resume < ApplicationRecord
  validates :content, presence: { message: "请填写简历描述" }
  validates :attachment, presence: { message: "请选择简历文档" }

  mount_uploader :attachment, AttachmentUploader

  belongs_to :user
  belongs_to :job

  validates :content, presence: true

  # scope :recent, -> { order('created_at DESC') }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :recent, -> { order('created_at DESC') }
  # scope :published, -> { where(is_hidden: false) }
  scope :lower_wage, -> {order('wage DESC')}
  scope :upper_wage, -> {order('wage ASC')}

  scope :random5, -> { limit(5).order("RANDOM()") }

  scope :wage1, -> { where('wage <= 5') }
  scope :wage2, -> { where('wage between 5 and 10') }
  scope :wage3, -> { where('wage between 10 and 15') }
  scope :wage4, -> { where('wage between 15 and 25') }
  scope :wage5, -> { where('wage >= 25') }


end
