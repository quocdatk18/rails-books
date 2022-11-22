class Admin::SessionsController < Devise::SessionsController
  private

  def after_sign_in_path_for(current_admin)
    if current_admin
      admin_dashboard_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(_resource)
    new_admin_session_path
  end
end
