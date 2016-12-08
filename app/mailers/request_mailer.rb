class RequestMailer < ApplicationMailer
  def send_email_accepted_request request
    @request = request
    mail to: @request.user.email, subject: t("requests.book")
  end
end
