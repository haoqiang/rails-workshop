class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update]
  def index
    @attendances = Attendance.all
  end

  def show
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to @attendance, notice: 'Attendance was successfully updated.'
    else
      render :edit
    end
  end

  def edit
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:has_attended)
  end
end
