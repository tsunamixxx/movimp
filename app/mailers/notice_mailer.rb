class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_review.subject
  #


  def sendmail_review(review)
    @review = review

    mail to: "tsunami0108@gmail.com",
    subject: '【Movimp】レビューが投稿されました'
  end
end
