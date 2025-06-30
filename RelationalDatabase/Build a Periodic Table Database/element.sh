PSQL="psql --username=postgres --dbname=periodic_table -t --no-align -c"

arg=$1

if [[ -z $arg ]]; then
  echo "Please provide an element as an argument."
else
  # Determine how to search: by atomic_number, symbol, or name
  if [[ $arg =~ ^[0-9]+$ ]]; then
    CONDITION="e.atomic_number = $arg"
  elif [[ $arg =~ ^[A-Za-z]{1,2}$ ]]; then
    CONDITION="e.symbol = '$arg'"
  else
    CONDITION="e.name = '$arg'"
  fi

  RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE $CONDITION;")

  if [[ -z $RESULT ]]; then
    echo "I could not find that element in the database."
  else
    IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELT BOIL <<< "$RESULT"
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  fi
fi