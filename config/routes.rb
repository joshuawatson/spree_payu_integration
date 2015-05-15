Spree::Core::Engine.routes.draw do
  post '/payu/notify', to: 'payu#notify'
  get '/payu/pay_you_money', to: 'payu#pay_you_money'
end
