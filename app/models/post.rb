class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  enum status: { rascunho: 0, publicado: 1}
end
