class Spree::Users::Devise::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)
    _setup_appropriate_flash
    sign_in(resource_name, resource) if _successful_login?
    redirect_to _return_path
  end

  private

  def _setup_appropriate_flash
    set_flash_message(:notice, :signed_in)      if _successful_login?
    set_flash_message(:error, :sign_in_failed)  if _failed_login?    
  end

  def _failed_login?
    !_successful_login?
  end

  def _successful_login?
    @login_result ||= resource.present? && is_navigational_format?
  end

  def _return_path
    return login_path if resource.blank?
    return request.referer if request.referer.present?
    return params[:back] if params[:back].present?
    return root_path
  end
end