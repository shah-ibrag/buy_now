def create
    Rails.logger.debug "Customer Params: #{customer_params.inspect}"
    Rails.logger.debug "Order Params: #{order_params.inspect}"
  
    @customer = Customer.new(customer_params)
    if @customer.save
      @order = Order.new(order_params)
      @order.customer = @customer
      @order.total_price = calculate_total_price
      if @order.save
        save_order_items
        session[:cart] = []
        redirect_to order_path(@order), notice: 'Order was successfully created.'
      else
        Rails.logger.debug "Order Save Errors: #{@order.errors.full_messages}"
        render :new
      end
    else
      Rails.logger.debug "Customer Save Errors: #{@customer.errors.full_messages}"
      render :new
    end
  end