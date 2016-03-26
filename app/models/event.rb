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

  def admin_users
  	users.where('attendances.user_type' => 'ADMIN')
  end

  def students
  	attendances.where(user_type: 'STUDENT')
  end

  def attendance_rate
  	total_attendance = students.count
  	actual_attendance = students.where(has_attended: true).count
  	[actual_attendance, total_attendance]
  end
end
