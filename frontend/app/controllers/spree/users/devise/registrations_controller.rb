class Spree::Users::Devise::RegistrationsController < Devise::RegistrationsController
  private

  def after_sign_up_path_for(user)
    return redirect_to _return_path if _return_path.present?
    return redirect_to user_path user if user.is_a? Spree::User
    return redirect_to root_path
  end

  def _return_path
    params[:back] || request.referer
  end

  def after_inactive_sign_up_path_for(user)
    after_sign_up_path_for user
  end
end