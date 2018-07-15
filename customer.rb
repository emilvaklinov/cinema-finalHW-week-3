require_relative('db/sql_runner')
require_relative('film')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(optional)
    @id = optional['id'].to_i if optional['id']
    @name = optional['name']
    @funds = optional['funds'].to_i

  end

  # CREATE
  def save()
    db = PG.connect({ dbname: 'cinema', host: 'localhost' })
    sql = "INSERT INTO customers (name, funds)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i

  end

  # READ
  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values) # array of hashes
    customer_hash = result.first
    return Customer.new(customer_hash)

  end

  # UPDATE
  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  # DELETE
  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def booked_films()
    sql = "SELECT films.* FROM films INNER JOIN tickets
    ON films.id = tickets.films_id"
    WHERE tickets.customer_id = $1;
    values = [@id]
    result = SqlRunner.run(sql, values) #array of hashes
    booked_films = result.map { |film| Film.new(film)}
    return booked_films
  end

  def ticket_count()
    return self.booked_films.count
  end

end
