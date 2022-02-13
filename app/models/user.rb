class User < ApplicationRecord
    has_secure_password

    attr_accessor :remember_token

    before_save :downcase_email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX }, 
              uniqueness: { case_sensitive: false }
    validates :password, presence: true, 
                         length: { minimum: 6 }, 
                         allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST 
                                                    : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end 
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(attribute, token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password? token
    end

private
    def downcase_email
        self.email.downcase!
    end
end
