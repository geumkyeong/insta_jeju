class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    #text 필드 미작성시 경고
    # validates :image, presence: { message: "이미지를 제출해주세요."}
    validates :image, presence: true
    validates :content, presence: true
    # 최후의 수단
    #로그인 된 상태가 아니면 글 작성 안됨(user id 빈값이 들어올 시)
    validates :user_id, presence: true
    
    #Validation Helpers
        # acceptance
        # validates_associated
        # confirmation
        # exclusion
        # format
        # inclusion
        # length
        # numericality
        # presence
        # absence
        # uniqueness
        # validates_with
        # validates_each
     
     has_many :likes
     has_many :like_users, through: :likes, source: :user
     
     def toggle_like(user)
        if self.like_users.include?(user)
            self.like_users.delete(user)
        else
            self.like_users.push(user)
        end
     end
    
        belongs_to :user
end
