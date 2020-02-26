class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :season_num, :season_title, :season_synopsis, :episodes

  belongs_to :movie

  # ActiveModelSerializer defaults to only one-level serialization, therefore manual handling here
  def episodes
    results = []
    e = Episode.where(season_id: object.id).order(episode_num: :asc)
    e.each do |episode|
      results << {
        episode_num: episode.episode_num,
        episode_title: episode.episode_title,
        qualities: episode.find_quality
      }
    end
    results
  end

  def created_at
    object.created_at.to_datetime.rfc3339
  end
end
