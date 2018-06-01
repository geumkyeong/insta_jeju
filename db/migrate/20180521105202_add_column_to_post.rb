class AddColumnToPost < ActiveRecord::Migration[5.2]
  def change
    #Post와 User 관계설정을 위해 add_colmn을 생성하고 user_id를 저장
    add_reference :posts, :user, index: true
    # = add_column :post, :user_id, :integer, index: true
    #post 컨트롤러에 user 데이터 column 을 생성
  end
end
