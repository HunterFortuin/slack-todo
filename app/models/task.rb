class Task < ActiveRecord::Base
    belongs_to :user

    validates_presence_of :description, :user_id
end
