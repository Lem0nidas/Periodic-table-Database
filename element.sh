#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
 then
  ELEMENT_DETAILS=$($PSQL "SELECT elements.atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number FULL JOIN types ON properties.type_id=types.type_id WHERE (elements.atomic_number=$1);")

  if [[ -z $ELEMENT_DETAILS ]] 
  then 
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT_DETAILS" | while read ATOMIC_NUM B SYMBOL B NAME B MASS B MELTING B BOILING B TYPE
    do
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
else
  ELEMENT_DETAILS=$($PSQL "SELECT elements.atomic_number,symbol,name,atomic_mass,melting_point_celsius,boiling_point_celsius,type FROM elements FULL JOIN properties ON elements.atomic_number=properties.atomic_number FULL JOIN types ON properties.type_id=types.type_id WHERE (elements.symbol='$1' OR elements.name='$1');")

  if [[ -z $ELEMENT_DETAILS ]] 
  then 
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT_DETAILS" | while read ATOMIC_NUM B SYMBOL B NAME B MASS B MELTING B BOILING B TYPE
    do
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi