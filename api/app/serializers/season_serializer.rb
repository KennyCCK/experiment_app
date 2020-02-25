class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :season_num, :season_title, :season_synopsis, :episodes

  belongs_to :movie

  def episodes
    Episode.select(:episode_num, :episode_title, :episode_plot, :created_at)
      .where(season_id: object.id)
      .order(episode_num: :asc)
      .as_json(except: :id)
  end

  def created_at
    object.created_at.to_datetime.rfc3339
  end
end
