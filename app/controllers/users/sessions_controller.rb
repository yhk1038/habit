class Users::SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]
    before_action :set_user, only: [:show]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # GET /resource/:id
    def show
        # 만약 조회되는 사용자의 계정이 비공개로 설정되어 있는 경우에
        # if @user.private
        #     # 조회하는 사용자가 로그인이 되어있는지 우선 체크한 뒤, 본인인지 확인하여 통과시키고
        #     # 아닌 경우 뒤로 돌려보낸다. (HTTP_REFERER 를 상속받지 않은 경우엔 fallback_location 으로 보낸다)
        #     redirect_back fallback_location: root_path if (not user_signed_in?) || (@user.id != current_user.id)
        # end
        render template: '/devise/sessions/show'
    end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end
end
