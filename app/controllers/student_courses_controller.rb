class StudentCoursesController < ApplicationController
  def create
    course = Course.find(params[:course_id])
    if current_user.courses.include?(course)
      flash[:notice] = 'Something was wrong with your enrollment'
      redirect_to root_path
    else
      StudentCourse.create(course: course, student: current_user)
      flash[:notice] = "You have successfully enroll in #{course.short_name}"
      redirect_to current_user
    end
  end
end