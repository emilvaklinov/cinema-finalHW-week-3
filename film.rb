require_relative('db/sql_runner')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(optional)
    @id = optional['id'].to_i if optional['id']
    @title = optional['title']
    @price = optional['price'].to_i if optional['price']

  end

  # CREATE
  def save
    db = PG.connect({ dbname: 'cinema', host: 'localhost' })
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  # READ
  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values) # array of hashes
    film_hash = result.first
    return Film.new(film_hash)


  end

  # UPDATE
  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  # DELETE
  def delete
    sql = "DELETE FROM films WHERE id = $1 "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # List all customers a film has booked to see.
  def all_customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets on customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values) #array of hashes
    booked_customers = result.map { |customer| Customer.new(customer)}
    return booked_customers
  end



end
