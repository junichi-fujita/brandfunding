class ArtisanGenreList < ApplicationRecord
  has_many :select_genre_in_artisans, dependent: :destroy
  has_many :artisan_profiles, through: :select_genre_in_artisans
end
