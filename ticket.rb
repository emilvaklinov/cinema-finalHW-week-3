require_relative('db/sql_runner')


class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(optional)
    @id = optional['id'].to_i if optional['id']
    @customer_id = optional['customer_id'].to_i if optional['customer_id']
    @film_id = optional['film_id'].to_i if optional['film_id']

  end

  # CREATE
  def save
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  #  READ
def self.find(id)
  sql = "SELECT * FROM tickets WHERE id = $1"
  values = [id]
  result = SqlRunner.run(sql, values) # array of hashes
  ticket_hash = result.first
  return Ticket.new(ticket_hash)
end

  # UPDATE
  def update
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  # DELETE
def delete
  sql = "DELETE FROM tickets WHERE id = $1"
  values = [id]
  SqlRunner.run(sql, values)

end

end
