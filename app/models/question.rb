class Question < ActiveRecord::Base

  has_many :answers

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments

  validates :title, :body, presence: true

  belongs_to :user

  after_create :update_reputation

  private

  def update_reputation

    CalculateReputationJob.perform_later(self)

  end

end
