class ApplicationController < ActionController::Base
    #CanCan 에러 발생 시 예외처리(e.message 표시)
    rescue_from CanCan::AccessDenied do |e|
        respond_to do |format|
            format.json {} #응답형식을 json 형태로 보냄
            format.js {}
            format.html { redirect_to root_path, notice: e.message }
        end
    end
    
end
