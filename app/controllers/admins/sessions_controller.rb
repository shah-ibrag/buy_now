class Admins::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    if self.resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      redirect_to new_administrator_session_path, alert: "Invalid email or password"
    end
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(Administrator)
      admin_dashboard_path
    else
      root_path
    end
  end
end