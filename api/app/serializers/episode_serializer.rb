class EpisodeSerializer < ActiveModel::Serializer
  attributes :episode_num, :episode_title, :episode_plot

  belongs_to :season

  def created_at
    object.created_at.to_datetime.rfc3339
  end
end
