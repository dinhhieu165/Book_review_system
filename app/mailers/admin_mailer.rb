class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.approve_request.subject
  #
  def approve_request request
    @request = request

    mail to: @request.user.email,
         subject: t.("admin.mailer.approve_request.subject")
  end
end
