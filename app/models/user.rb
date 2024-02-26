class User < ApplicationRecord
    # This is an associtation it is used to simply create relation between atleast 2 models.  Here User model has many Article models. 
    has_many :articles
end
