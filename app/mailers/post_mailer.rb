class PostMailer < ApplicationMailer
    def post_mailer(post)
        @post=post
      mail to: @post.user.email, subject: "投稿内容の確認メール"
    end
end
