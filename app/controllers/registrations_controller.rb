class RegistrationsController < Devise::RegistrationsController

  /  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
/

  def update
    @user = User.find(current_user.id)
    params[:user].permit(:occupation, :level_id, :type, :firstname, :lastname, :birthdate, :description, :gender, :phonenumber)

    successfully_updated = if needs_password?(@user, params)
                             @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
                           else
                             # remove the virtual current_password attribute
                             # update_without_password doesn't know how to ignore it
                             params[:user].delete(:current_password)
                             @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
                           end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end

  end


  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
        params[:user][:password].present? ||
        params[:user][:password_confirmation].present?
  end


end