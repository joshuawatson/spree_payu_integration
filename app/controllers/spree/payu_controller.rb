module Spree
  class PayuController < Spree::BaseController
    protect_from_forgery except: [:notify, :continue]

    def notify
      response = OpenPayU::Order.retrieve(params[:order][:orderId])
      order_info = response.parsed_data['orders']['orders'].first
      order = Spree::Order.find(order_info['extOrderId'])
      payment = order.payments.last

      unless payment.completed? || payment.failed?
        case order_info['status']
        when 'CANCELED', 'REJECTED'
          payment.failure!
        when 'COMPLETED'
          payment.complete!
        end
      end

      render json: OpenPayU::Order.build_notify_response(response.req_id)
    end

    def pay_you_money
    @name = "#{params[:buyer][:first_name]}".strip  
     p "=========================#{"#{params[:merchant_pos_id]}|#{params[:order]}|#{params[:total_amount]}|Prpduct Information|#{@name}|#{params[:buyer][:email]}|15|||||||||||eCwWELxi"}"
     @random = SecureRandom.hex
     p "=======@random====#{@random}"
     hash = Digest::SHA2.new(512).hexdigest("#{params[:merchant_pos_id]}|#{@random}|#{params[:total_amount]}|Prpduct Information|#{@name}|#{params[:buyer][:email]}|15|||||||||||salt")
     p "hash====#{hash}"
     p "params[:order]-===================#{params[:order]}"
    end
  end
end