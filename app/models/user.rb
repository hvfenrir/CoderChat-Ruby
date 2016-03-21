class User < ActiveRecord::Base
	has_secure_password

	validates :name, presence: true

	validates :email, uniqueness: true
	has_many :friendships
	has_many :friends, through: :friendships
	has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
	has_many :incoming_messages, :class_name => 'Message', :foreign_key => 'recipient_id'
	
	scope :all_friends_except, ->(user) { where.not(id: user) }
end
