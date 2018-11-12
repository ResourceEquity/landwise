module Users
  class RegistrationsController < Devise::RegistrationsController

    skip_before_action :verify_authenticity_token, only: [:destroy]

    prepend_before_action :check_captcha, only: [:create]

    def create
      super
    end

    def edit
      super
    end

    def update
      super
    end

    def destroy
      super
    end

    protected

      def after_inactive_sign_up_path_for(*)
        new_user_session_path
      end

      def after_update_path_for(*)
        edit_user_registration_path
      end

      def sign_up_params
        params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :password_confirmation
        )
      end

      def account_update_params
        params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :current_password,
          :password,
          :password_confirmation,
          :notification_interval,
          jurisdiction_ids: [],
          language_ids: [],
          category_ids: [],
          country_ids: [],
          topic_ids: []
        )
      end

      def update_resource(resource, params)
        if params[:password].present? || params[:password_confirmation].present?
          super
        else
          params.delete(:current_password)
          resource.update_without_password(params)
        end
      end

      def check_captcha
        user_params = sign_up_params
        user_params.delete(:token)
        self.resource = resource_class.new(user_params)
        resource.validate

        unless verify_recaptcha(model: resource)
          set_minimum_password_length
          respond_with resource
        end
      end
  end
end
