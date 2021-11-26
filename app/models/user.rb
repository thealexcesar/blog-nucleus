class User < ApplicationRecord
  enum tipo: {commun: 0, admin: 1}
  validates_presence_of :email
  delegate :nome, to: :user, prefix: true
end
