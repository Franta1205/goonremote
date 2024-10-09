class CheckoutController < ApplicationController
  def index
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: {
            name: "Job Posting",
            description: "Publish your job on our platform"
          },
          unit_amount: 2000
        },
        quantity: 1
      }],
      mode: "payment",
      success_url: root_url,
      cancel_url: root_url
    })

    redirect_to session.url, allow_other_host: true
  end
end
