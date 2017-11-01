def itinerary_sort(tickets)

  tickets = tickets.sort.reverse.group_by(&:first)
  itinerary = []

  visit = lambda { |airport| 
    visit[tickets[airport].pop[1]] while tickets[airport].any?
    itinerary << airport
  }

  visit["JFK"]
  itinerary.reverse
    
end

tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]

p itinerary_sort(tickets) === ["JFK", "ATL", "JFK", "SFO", "ATL", "SFO"]