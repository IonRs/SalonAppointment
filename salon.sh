#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

echo "1) cut
2) color
3) perm
4) style
5) trim"
read SERVICE_ID_SELECTED

while [[ $SERVICE_ID_SELECTED -lt 1 || $SERVICE_ID_SELECTED -gt 5 ]]
do
echo "1) cut
2) color
3) perm
4) style
5) trim"
read SERVICE_ID_SELECTED
done
echo $($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
echo "Phone Number:"
read CUSTOMER_PHONE

if [[ -z $($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'") ]]
then
  echo "What is your name?"
  read CUSTOMER_NAME
  VAR=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
else
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
fi
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
echo "Time:"
read SERVICE_TIME
VAR=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."