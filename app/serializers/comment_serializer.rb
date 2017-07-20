class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :post, :created_at
  belongs_to :user
  belongs_to :post
end
