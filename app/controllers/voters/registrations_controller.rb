# frozen_string_literal: true

class Voters::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # 新規登録後、ブラウザを閉じて再度rootにアクセスしても新規登録後の画面に遷移するための設定
  def create
    # ここでUser.new（と同等の操作）を行う
    build_resource(sign_up_params)

    # ここでUser.save（と同等の操作）を行う
    resource.save

    if resource.persisted?
      # 先程のresource.saveが成功していたら
      if resource.active_for_authentication?
        # confirmable/lockableどちらかのactive_for_authentication?がtrueだったら
        # flashメッセージを設定
        set_flash_message! :notice, :signed_up
        # サインアップ操作
        sign_up(resource_name, resource)
        # リダイレクト先を指定
        yield resource if block_given?
        session[:voter_id] = "voter"
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        # sessionを削除
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      # 先程のresource.saveが失敗していたら
      # passwordとpassword_confirmationをnilにする
      clean_up_passwords resource
      # validatable有効時に、パスワードの最小値を設定する
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

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

  # 更新（編集の反映）時にパスワード入力を省く
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # 更新後のパスを指定
  def after_update_path_for(resource)
    voterposts_path(resource)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :group])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :group])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    voterposts_path(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   voters_voters_index_path(resource)
  # end
end
