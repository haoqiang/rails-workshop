# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

  # associations
  has_many :attendances
  has_many :events, through: :attendances

  # validations
  validates :name, presence: true, length: { in: 2..255 }
  validates :email, presence: true, email: true, uniqueness: true, length: { maximum: 255 }
  validates :password, presence: true, length: { in: 6..40 }

  def managed_events
	events.where('attendances.user_type' => 'ADMIN')
  end

  def joined_events
	events.where('attendances.has_attended' => true, 'attendances.user_type' => 'STUDENT')
  end
end
