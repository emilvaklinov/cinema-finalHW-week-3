require_relative('customer')
require_relative('film')
require_relative('ticket')
require_relative('screening')

require('pry-byebug')


customer1 = Customer.new({'name' => 'John', 'funds' => 50})
customer2 = Customer.new({'name' => 'Gemma', 'funds' => 100})

customer1.save()
customer2.save()

film1 = Film.new({'title' => 'Spartacus', 'price' => 10})
film2 = Film.new({'title' => 'Solo', 'price' => 15})
film3 = Film.new({'title' => 'Haker', 'price' => 10})

film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id })
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id })
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id })

ticket1.save()
ticket2.save()
ticket3.save()

# ADD Screening
screening1 = Screening.new({'start_time' => '17:15', 'film_id' => film1_id, 'seats' => '10'})
screening2 = Screening.new({'start_time' => '19:15', 'film_id' => film1_id, 'seats' => '20'})
screening3 = Screening.new({'start_time' => '13:15', 'film_id' => film2_id, 'seats' => '30'})
screening4 = Screening.new({'start_time' => '16:15', 'film_id' => film3_id, 'seats' => '25'})
screening5 = Screening.new({'start_time' => '18:15', 'film_id' => film3_id, 'seats' => '25'})


screening1.save()
screening2.save()
screening3.save()
screening4.save()
screening5.save()


#
# ticket.customer_id = customer2.id
# John = Customer.find(1)
# Solo = Film.find(2)

# binding.pry
# nil

# TEST
# film1.price = '12'
# film1.title = 'Tarzan'
# film1.update()

# customer1.name = 'Emil'
# customer1.funds = '40'
# customer1.update()

# DELETING TESTS
# customer1.delete
# film2.delete
# ticket3.delete
