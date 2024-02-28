module ApplicationHelper
    def gravatar_for(user)
        email_address = user.email.downcase
        hash = Digest::MD5.hexdigest(email_address)
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}"
        # image_tag is helper method to generate img tag in a website. it takes atleast 1 arg. url 
        image_tag(gravatar_url, alt: user.username)
    end



end
