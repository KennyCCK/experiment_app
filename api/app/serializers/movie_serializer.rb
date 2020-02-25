class MovieSerializer < ActiveModel::Serializer
  attributes :movie_name, :movie_desc

  belongs_to :genre
  has_many :seasons

  def created_at
    object.created_at.to_datetime.rfc3339
  end
end
