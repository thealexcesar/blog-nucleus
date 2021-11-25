class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum tipo: { commun: 0, admin: 1 }
end
