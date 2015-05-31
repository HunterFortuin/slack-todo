class User < ActiveRecord::Base
  attr_accessor :current_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :tasks

  validates_presence_of :email, :slack_username
  validates_uniqueness_of :email
end
