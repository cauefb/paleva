class Establishment < ApplicationRecord
  belongs_to :user
  has_one :opening_hour, dependent: :destroy
end
