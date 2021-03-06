class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :first_name, :last_name, :full_name, :image_src
    has_many :trips

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def image_src
    object.image.url
  end
end
