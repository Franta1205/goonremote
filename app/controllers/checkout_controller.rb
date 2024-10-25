class CheckoutController < ApplicationController
  def index
    job = Job.find(params[:job_id])
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: {
            name: "Job Posting",
            description: "Publish your job on our platform"
          },
          unit_amount: 9900
        },
        quantity: 1
      }],
      mode: "payment",
      success_url: publish_job_url(job),
      cancel_url: root_url
    })

    redirect_to session.url, allow_other_host: true
  end
end
