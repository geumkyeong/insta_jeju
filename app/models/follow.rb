class Follow < ApplicationRecord
    #class_name: "User" : User 데이터에서 가져온 정보이다 선언.
    belongs_to :followee, class_name: "User"
    belongs_to :follower, class_name: "User"
end
