puts '-- Initializing Data...'

# Create a sample user
['newbie', 'novice', 'tester'].each do |name|
  email = "#{name}@email.com"
  unless User.find_by(email: email)
    user = User.new
    user.name = name
    user.email = email
    user.save
  end
end

# Create sample Genres
['Drama', 'Action', 'Sci-Fi'].each do |gen|
  unless Genre.find_by(name: gen)
    genre = Genre.new
    genre.name = gen
    genre.save
  end
end

# Create sample Qualities
['SD', 'HD', 'FHD', '4K', '8K'].each do |q|
  unless Quality.find_by(name: q)
    quality = Quality.new
    quality.name = q
    quality.save
  end
end

# Create sample Movies
sd = Quality.find_by(name: 'SD')
hd = Quality.find_by(name: 'HD')
uhd = Quality.find_by(name: '4K')
['Terminator', '300', 'Sword Art Online', 'Iron Man', 'Avengers: End Game'].each do |m|
  unless Movie.find_by(movie_name: m)
    movie = Movie.new
    movie.movie_name = m
    movie.genre_id = Genre.pluck(:id).sample
    movie.save

    if m == 'Sword Art Online'
      # Add "Season" 1 and 2
      [1, 2].each do |s|
        season = Season.new
        season.movie_id = movie.id
        season.season_num = s
        season.season_title = "This is season #{s}"
        season.save

        # Add a "Price"
        price = Price.new
        price.price_usd = 3.99
        price.price_type = 'rent'
        price.valid_days = 60
        price.quality_id = hd.id
        price.movie_id = movie.id
        price.season_id = season.id
        price.save

        # Add "Episodes"
        (1..10).each do |e|
          episode = Episode.new
          episode.season_id = season.id
          episode.episode_num = e
          episode.episode_title = "This is season #{s}, episode #{e}"
          episode.episode_plot = "plot abcdefghijk"
          episode.save

          # Register "Video" HD entry
          video = Video.new
          video.filename = 'file'
          video.ext = 'mp4'
          video.size = 10000
          video.quality_id = hd.id
          video.duration_mins = 23.5
          video.storage_path = 'path/to/file'
          video.movie_id = movie.id
          video.season_id = season.id
          video.episode_id = episode.id
          video.save

          # Register "Video" SD entry
          video = Video.new
          video.filename = 'file'
          video.ext = 'mp4'
          video.size = 10000
          video.quality_id = sd.id
          video.duration_mins = 23.5
          video.storage_path = 'path/to/file'
          video.movie_id = movie.id
          video.season_id = season.id
          video.episode_id = episode.id
          video.save
        end

      end

    else

      # Add a "Price"
      price = Price.new
      price.price_usd = 4.99
      price.price_type = 'rent'
      price.valid_days = 2
      price.quality_id = uhd.id
      price.movie_id = movie.id
      price.season_id = nil
      price.save

      # Register "Video" entry for standard movie
      video = Video.new
      video.filename = 'file'
      video.ext = 'mp4'
      video.size = 10000
      video.quality_id = uhd.id
      video.duration_mins = 60.5
      video.storage_path = 'path/to/file'
      video.movie_id = movie.id
      video.season_id = nil
      video.episode_id = nil
      video.save

    end

  end
end
puts '-- Data initialization done.'