class Team < ActiveRecord::Base
    has_many :user_teams
    has_many :users, through: :user_teams
    has_many :tasks, through: :users

    validates_presence_of :name, :slack_token
    validates_uniqueness_of :slack_token
end
