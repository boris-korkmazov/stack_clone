class Answer < ActiveRecord::Base

  belongs_to :question

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments

  validates :body, presence: true

  after_create :calculate_reputation

  private

  def calculate_reputation
    Reputation.delay.calculate(self)
  end



end
