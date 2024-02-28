class User < ApplicationRecord
    has_secure_password
    before_save {self.email = email.downcase}
    # This is general uniqueness check but the below line is for case insensitivity as for username, Swikar should be equal to swikar
    # validates :username, presence: true, uniqueness: true, length: {minimum:2, maximum:25}
    validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:2, maximum:25}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum:105}, format: {with: VALID_EMAIL_REGEX}
    # This is an associtation it is used to simply create relation between atleast 2 models.  Here User model has many Article models. 
    # This dependent: : destroy ties destroy of user with all the deletion of related articles too 
    has_many :articles, dependent: :destroy

end
