class UserLibrarySerializer < ActiveModel::Serializer
  attributes :id, :remaining_time_seconds, :movie, :season, :episodes

  # belongs_to :user
  # belongs_to :purchase_transaction
  # belongs_to :movie
  # belongs_to :season

  def movie
    m = Movie.find_by(id: object.movie_id)
    {
      movie: {
        id: m.id,
        movie_name: m.movie_name,
        movie_desc: m.movie_desc,
        genre: m.genre.name,
        quality: object.season_id ? nil : object.purchase_transaction.purchase_quality,
        created_at: m.created_at
      }
    }
  end

  def season
    s = Season.find_by(id: object.season_id, movie_id: object.movie_id) if object.season_id
    s
  end

  def episodes
    results = []
    e = Episode.where(season_id: object.season_id).order(episode_num: :asc)
    e.each do |episode|
      results << {
        episode_num: episode.episode_num,
        episode_title: episode.episode_title,
        quality: object.purchase_transaction.purchase_quality
      }
    end
    results
  end

  def remaining_time_seconds
    object.remaining_time_seconds
  end

  def created_at
    object.created_at.to_datetime.rfc3339
  end
end
