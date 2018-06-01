class UsersController < ApplicationController
    before_action :set_user
    load_and_authorize_resource
    #user 컨트롤러를 사용하여 권한을 부여할수 있ㄷ로록
    
    # show page : 다른 사람의 글들도 보여주는 페이지
    
    #GET 'user/:id'
    def show
        #해당유저의 정보를 불러들여 페이지를 보여줌
        @posts = @user.posts
    end
    #POST 'users/:id/follow'
    def follow
        @user.toggle_follow(current_user)
        redirect_back(fallback_location: root_path)
    end
    private
    def set_user
         @user = User.find(params[:id])
    end
end
