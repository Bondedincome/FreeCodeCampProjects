#! /bin/bash

# You should display a numbered list of the services you offer before the first prompt for input, 
# each with the format #) <service>. For example, 1) cut, where 1 is the service_id

PSQL="psql --username=postgres --dbname=salon --no-align --tuples-only -c"

echo -e "~~~~~ MY SALON ~~~~~"
echo -e "Welcome to My Salon, how can I help you?"
menu () {
  i=1
  $PSQL 'SELECT name FROM services;' | while read name
  do
    echo "$i) $name"
    ((i++))
  done
}

get_service_count() {
  $PSQL "SELECT COUNT(*) FROM services;"
}

SERVICE_COUNT=$(get_service_count)

while true
do
  menu
  read SERVICE_ID_SELECTED
  if [[ "$SERVICE_ID_SELECTED" =~ ^[0-9]+$ ]] && [ "$SERVICE_ID_SELECTED" -ge 1 ] && [ "$SERVICE_ID_SELECTED" -le "$SERVICE_COUNT" ]; then
    break
  else
    echo -e "\nI could not find that service. What would you like today?"
  fi
done

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")

if [[ -z $CUSTOMER_NAME ]]; then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  $PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');" > /dev/null
fi

echo -e "\nWhat time would you like your service?"
read SERVICE_TIME

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

$PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');" > /dev/null

echo -e "\nI have put you down for a $( $PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;" ) at $SERVICE_TIME, $CUSTOMER_NAME."