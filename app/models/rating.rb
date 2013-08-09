class Rating < ActiveRecord::Base
  attr_accessible :body, :stars, :title, :user_id, :product_id

  def user
    @user ||= User.find(user_id)
  end

  def editable?
    created_at > Time.now.utc - 900
  end

  def self.find_unique(params)
    result = find_by_user_id_and_product_id(params[:user_id], params[:product_id])
    result || raise(ActiveRecord::RecordNotFound)
  end
end
