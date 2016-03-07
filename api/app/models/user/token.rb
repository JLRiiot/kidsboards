# Token class
# Fileds:
#  [Integer]    id
#  [String]     code
#  [DateTime]   created_at
#  [Integer]    is_expired
#  [Integer]    token_type
#  [User::User] user
class User::Token < ActiveRecord::Base
  belongs_to :user, inverse_of: :tokens, class_name: 'User::User'

  # Types
  # For Login
  TYPE_LOGIN = 0
  # For confirmation
  TYPE_CONFIRMATION = 1
  # For recovery
  TYPE_RECOVERY = 2

  # New token with user and type
  # @param [User::User] user
  # @param [Integer] type
  def initialize(user, type)
    super()
    self.user = user
    self.code = SecureRandom.hex
    self.created_at = DateTime.now.utc
    self.is_expired = false
    self.token_type = type
  end

  # Sets expired flag
  def expire
    self.is_expired = true
    save
  end
end