# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  #before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
    # Find the user record
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    # Permit the additional attributes for update
    resource_params = update_resource_params

    # Update the user record with the permitted attributes
    if resource.update(resource_params)
      set_flash_message :notice, :updated
      redirect_to user_path(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
  

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :phone])
  end

  def update_resource_params
    params.require(:user).permit(:name, :last_name, :phone, :profile, :email, :current_password).tap do |whitelisted|
      if params[:user][:password].present?
        whitelisted[:password] = params[:user][:password]
        whitelisted[:password_confirmation] = params[:user][:password_confirmation]
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :last_name, :phone, :profile, :email, :password, :password_confirmation, :current_password])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
