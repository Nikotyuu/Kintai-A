class Base < ApplicationRecord
   validates :base_id, presence: true, length: { maximum: 10 }, numericality: { greater_than: 0 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 30 }
end
