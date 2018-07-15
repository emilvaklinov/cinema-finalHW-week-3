require_relative('db/sql_runner')


class Screening

  attr_reader :id
  attr_accessor :start_time, :film_id, :seats

  def initialize(optional)
    @id = optional['id'].to_i if optional['id']
    @start_time = optional['start_time']
    @film_id = optional['film_id'].to_i if optional['film_id']
    @seats = optional('seats')

  end


  #  CREATE
  sql = "INSERT INTO screenings (start_time, film_id, seats)
  VALUES ($1, $2, $3) RETURNING id"
  values = [@start_time, @film_id, @seats]
  screening = SqlRunner.run(sql, values).first
  @id = screening['id'].to_i
end

#  READ
def self.find(id)
  sql = "SELECT * FROM screenings WHERE in = $1"
  values = [id]
  result = SqlRunner.run(sql, values) # array of hashes
  screening = result.first
  return Screening.new(screening)
end




end
