# == Schema Information
#
# Table name: attendances
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  event_id     :integer
#  has_attended :boolean
#  user_type    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Attendance < ActiveRecord::Base

  VALID_USER_TYPE = %w(ADMIN STUDENT)

  # associations
  belongs_to :user
  belongs_to :event

  # validations
  validates :has_attended, inclusion: { in: [true, false] }
  validates :user_type, inclusion: { in: VALID_USER_TYPE }, presence: true
end
