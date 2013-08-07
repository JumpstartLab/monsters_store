class Rating < ActiveRecord::Base
  attr_accessible :body, :stars, :title, :user_id, :product_id

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :stars, presence: true, inclusion: 0..5

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
