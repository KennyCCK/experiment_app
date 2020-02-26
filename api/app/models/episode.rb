class Episode < ApplicationRecord
  belongs_to :season
  has_many :videos

  def find_quality
    quality_ids = Video.where(season_id: season.id, episode_id: id).pluck(:quality_id)
    qualities = Quality.where(id: quality_ids).pluck(:name)
    qualities
  end
end
