class UserMailer < ApplicationMailer
    default from: "musicappadmin@example.com"

    def welcome_email(user)
        @user = user

        mail(to: @user.email, subject: "Welcome to Music App!")
    end
end
