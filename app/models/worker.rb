class Worker < ApplicationRecord
    has_many :shifts
    validates :name, presence: true
end
