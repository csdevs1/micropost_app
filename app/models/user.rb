class User < ActiveRecord::Base    
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    #  validates_length_of :name, :maximum => 4, :tokenizer => lambda {|str| str.scan(/\w+/) } This ensures that a user enter only a 4 names
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
    validates :email, format: { with: VALID_EMAIL_REGEX }
    validates :username, presence: true, length: { maximum: 20 }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
