class Player < ApplicationRecord
    has_secure_password

    validates :name, presence: true, uniqueness: true
    validates :password_digest, presence: true
end
