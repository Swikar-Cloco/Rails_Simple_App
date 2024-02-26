class Article <ApplicationRecord
    validates :title, presence: true, length: { minimum:4,  maximum:100 }
    validates :description, presence: true, length: { minimum:10,  maximum:300 }
    # The below line is an association -- used when a model belongs to another model and it has counter part(like has_many, has_one) on the other model mentioned here --> user for now (User)
    # belongs_to association assumes that the foreign key column in the database will be named as <association_name>_id, here, user_id in the articles table
    belongs_to :user
end