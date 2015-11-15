-- Most populous states

MATCH (state:State) RETURN state ORDER BY state.population DESC LIMIT 10


-- Every state that borders

MATCH (:State {name: 'Colorado'})--(state:State) RETURN state


-- At most two states away

MATCH (:State {name: 'Colorado'})-[:BORDERS*1..2]-(state:State) RETURN state

// States with the most bordering states

MATCH (state:State)-[border:BORDERS]-(other:State) RETURN state, COUNT(border) ORDER BY COUNT(border) DESC LIMIT 10


// Biggest population differences between bordering states (try without the arrow, too!)

MATCH (state:State)-[:BORDERS]->(other:State) RETURN state, other ORDER BY ABS(state.population - other.population) DESC LIMIT 10


// Most populous bordering states

MATCH (state:State)-[:BORDERS]-(others:State) RETURN state.name, SUM(others.population) ORDER BY SUM(others.population) DESC LIMIT 5



// Bordering states in common between two states

MATCH (state:State {name:'Tennessee'})-[:BORDERS]-(common:State)-[:BORDERS]-(other:State{name:'Missouri'}) RETURN common.name


// States with only a certain number of borders

// MATCH (state:State)-[border:BORDERS]-(:State) WHERE count(border) = 1 RETURN state.name, count(border)  --- BAD SYNTAX!

// use WITH (I think all returns must be in WITH as well)

MATCH (state:State)-[border:BORDERS]-(:State) WITH state.name as name, COUNT(border) as borders WHERE borders = 1 RETURN name, borders


// Least number of border crossings between states

MATCH (colorado:State {name: "Colorado"}), (new_york:State {name: "New York"}),
      path = shortestpath((colorado)-[:BORDERS*]-(new_york))
RETURN extract(state IN nodes(path) | state.name)


// SELECT everything

MATCH (state:State) RETURN state


// Delete everything

MATCH (n) DETACH DELETE n
