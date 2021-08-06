class LoginsController < ApplicationController
  skip_before_action :require_user, only: %i[new create]

  def new; end

  def create
    student = Student.find_by(email: params[:logins][:email].downcase)
    if student&.authenticate(params[:logins][:password])
      session[:student_id] = student.id
      flash[:notice] = 'You have successfully logged in'
      redirect_to student
    else
      flash.now[:notice] = 'Something was wrong with your login'
      render :new
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:notice] = 'You have successfully logged out'
    redirect_to login_path
  end
end