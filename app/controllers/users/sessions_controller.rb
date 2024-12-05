class Users::SessionsController < Devise::SessionsController
  def create
    Rails.logger.debug "Attempting to authenticate user with email: #{params[:user][:email]}"
    Rails.logger.debug "User params: #{params[:user].inspect}"
    self.resource = warden.authenticate!(auth_options)
    if self.resource
      Rails.logger.debug "User authenticated successfully: #{self.resource.email}"
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      Rails.logger.debug "User authentication failed"
      redirect_to new_user_session_path, alert: "Invalid email or password"
    end
  rescue => e
    Rails.logger.error "Error during user authentication: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    redirect_to new_user_session_path, alert: "An error occurred during authentication"
  end

  protected

  def after_sign_in_path_for(resource)
    root_path
  end
end