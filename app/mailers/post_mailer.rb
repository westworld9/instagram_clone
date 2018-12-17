class PostMailer < ApplicationMailer
    def post_mailer(post)
        @post=post
      mail to: @post.user.email, subject:"お問い合わせの確認メール"
    end
end
