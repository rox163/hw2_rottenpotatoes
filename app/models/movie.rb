class Movie < ActiveRecord::Base

#  def initialize
    @all_ratings = ["G", "PG", "PG-13", "R"]
# end

  def self.get_all_ratings
    ["G", "PG", "PG-13", "R"]
  end

end
