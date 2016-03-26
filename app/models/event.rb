# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  date        :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base

  # associations
  has_many :attendances
  has_many :users, through: :attendances

  # validations
  validates :title, presence: true, length: { in: 2..255 }
  validates_datetime :date
end
