class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # devise가 미리 생성한 로그인 안하면 접근 안됨(index, show 제외)
  before_action :authenticate_user!#, except:[:index, :show]
  load_and_authorize_resource
  # = before_action :check_user, only: [:edit, :update, :destroy]
  
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    if params.has_key?(:content)
      @posts = Post.where('content like ?', "%#{params[:content]}%")
      # #{params[:content]} : 일부를 넣어 검색해도 검색이 되도록.
    else
      @posts = Post.all.order(created_at: :desc)
      # @posts = Post.where(user_id: current_user.followees.ids.push(current_user.id))
    end
    
    #DB에서 유저가 팔로우 하는 사람과 현재유저 id를 불러옴 
    @posts = Post.limit([0,1])
    @posts = Post.order(created_at: :desc).find([1,2])
    #최신글일수록 상단에 뜸
    # @posts = post.order(Create_at: :desc).first # - 1 or N
    # find(1),find(2)-1
    # order() -N
    # limit(n) - 1 or N
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    
    # @post = Post.new(post_params)
    # = @post.user.id = current_user.id
    @post = current_user.posts.new(post_params)
    
    respond_to do |format|
      if @post.save
        #POST를 분기해서 저장
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
      @post.toggle_like(current_user)
      redirect_back(fallback_location: root_path)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image, :content)
    end
    
    # def check_user
    #   #현재 유저와 post유저가 같지 않으면 루트 패스로 이동
    #   #and return 밑에 코드가 실행되지 않도록 프로그램을 종료
    #   redirect_to root_path, notice: '권한이 없습니다!' and return unless @post.user == current_user
    #   # = @post.user_id == current_user.id
    # end
    
    def mypage
      #자신이 작성한 페이지만을 보냄
      @posts = current_user.posts
    end
    
    
end
