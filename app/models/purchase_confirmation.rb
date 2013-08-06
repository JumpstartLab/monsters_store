class PurchaseConfirmation
  def self.create(order)
    user = order.user
    items = order.order_items.map do |item|
      {"title" => item.title, "quantity" => item.quantity}
    end
    order_data = {
      "email" => user.email,
      "name" => user.full_name,
      "items" => order.order_items,
      "total" => order.total,
      "items" => items
    }
    message = {"type" => "purchase_confirmation", "data" => order_data}
    $redis.publish("email_notifications", message.to_json)
  end
end