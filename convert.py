import csv

f = open('states.csv', 'rb')
csvr = csv.reader(f)

states = [{'var': l[0].lower().replace(' ', '_'), 'name': l[0], 'population': int(l[1]), 'borders':[s.strip() for s in l[2:] if s.strip()]} for l in csvr]

clauses = []
for state in states:
    clauses.append("({var}:State {{name:'{name}', population: {population!s}}})".format(**state))
    for border in state['borders']:
        if state['name'] > border:
          clauses.append("({0})-[:BORDERS]->({1})".format(border.lower().replace(' ', '_'), state['name'].lower().replace(' ', '_')))

create = "CREATE {0}".format(', '.join(clauses))
