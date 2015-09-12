class Question < ActiveRecord::Base

  has_many :answers

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments

  validates :title, :body, presence: true

end
