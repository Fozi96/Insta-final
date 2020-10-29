class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: @post.user.email,  subject: "Inquiry email confirmation"
  end
end
