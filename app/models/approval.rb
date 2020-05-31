class Approval < ApplicationRecord
  belongs_to :user
  
  validates :month, presence: true
  validates :decision, presence: true
  validates :authorizer, presence: true
  
end
