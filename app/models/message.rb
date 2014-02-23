class Message < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	belongs_to :conversation
	has_many :subscriptions, through: :conversation

	validates :conversation_id, :author_id, :body, presence: true
end