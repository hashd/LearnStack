list_concat = fn a,b -> a++b end
list_concat.([:a, :b], [:c, :d])

sum = fn a,b,c -> a+b+c end
sum.(1,2,3)

pair_tuple_to_list = fn {a, b} -> [a,b] end
pair_tuple_to_list.( { 1234, 5678 } )

tax_rates = [ NC: 0.075, TX: 0.08 ]
orders = [[ id: 123, ship_to: :NC, net_amount: 100.00 ],
[ id: 124, ship_to: :OK, net_amount: 35.50 ],
[ id: 125, ship_to: :TX, net_amount: 24.00 ],
[ id: 126, ship_to: :TX, net_amount: 44.80 ],
[ id: 127, ship_to: :NC, net_amount: 25.00 ],
[ id: 128, ship_to: :MA, net_amount: 10.00 ],
[ id: 129, ship_to: :CA, net_amount: 102.00 ],
[ id: 120, ship_to: :NC, net_amount: 50.00 ]]
for order <- orders, do: [ Keyword.put_new(order, :total_amount, order[:net_amount] + order[:net_amount] * (tax_rates[order[:ship_to]] || 0)) ]