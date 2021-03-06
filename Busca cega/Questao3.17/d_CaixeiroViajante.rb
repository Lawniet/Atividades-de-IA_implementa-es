# 3.17 d) Implemente o algoritmo e aplique-o a instâncias (...) do caixeiroviajante.
# Adapter: Lauany Reis da Silva

City = Struct.new(:x, :y, :name)
Route = Struct.new(:cities, :distance)
 
CITIES = []
 
def add_city(x, y, name)
  CITIES << City.new(x, y, name)
end
 
def calculate_distance(from, to)
  Math.sqrt((to.x-from.x)**2 + (to.y-from.y)**2).to_i
end
# Algoritmo de busca  
def go_route(route, routes)
  if route.cities.length == CITIES.length
    route.distance += calculate_distance(route.cities[-1], route.cities[0])
    route.cities << route.cities[0]
    routes << route
    return
  end
 
  for city in CITIES - route.cities
    # Algoritmo A*
    new_route = Route.new(route.cities + [city], route.distance + calculate_distance(route.cities.last, city))
    go_route(new_route, routes)
  end
end
 
def go(routes, start_city)
  route = Route.new([start_city], 0)
  go_route(route, routes)
  routes
end
 
def r(n=10000)
  (rand*n).to_i
end
 
for name in ["Python", "Java", "PHP", "C", "Ruby", "BrainF*ck", "JavaScript"]
  add_city(r, r, name)
end
 
best_routes = go([], CITIES.shuffle[0]).sort_by(&:distance)[0...10]
 
puts "Exibindo as 10 melhores rotas!"
best_routes.each_with_index do |route, i|
  puts "\n"*2
  puts "Rota ##{i+1}"
  puts " Distancia percorrida: #{route.distance}"
  puts " Cidades:"
 
  last_city = nil
  distance  = 0
  puts "%10s | %07s, %7s | %10s | %s" % [ "     Cidades", "Cord X", "Cord Y", "Distancia", "Distancia da ultima cidade"]
  route.cities.each do |city|
    distance_between_cities = (last_city.nil? ? 0 : calculate_distance(last_city, city))
    puts "  %10s | x:%.05i, y:%.05i | %.10i | %.10i" % [city.name, city.x, city.y, distance+=distance_between_cities, distance_between_cities]
    last_city = city
  end
end
