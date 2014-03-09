class AdminsController < AuthenticatedController
  before_filter :ensure_admin

  def ensure_admin
    flash[:danger] = "You do not have access to that area."
    redirect_to root_path unless current_user.admin?
  end
end
