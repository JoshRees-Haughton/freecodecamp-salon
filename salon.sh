#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Welcome to the salon, what service do you require?" 
  echo -e "\n1) cut\n2) dye\n3) style\n4) exit"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUT ;;
    2) DYE ;;
    3) STYLE ;;
    4) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

CUT() {
  SERVICE_SELECTED=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  #echo "$SERVICE_SELECTED"
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #echo "$PHONE_NUMBER"
  CUSTOMER_NAME=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  #echo "$CUSTOMER_NAME"
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    echo -e "\nPlease select an appointment time?"
    read SERVICE_TIME   
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo "$CUSTOMER_ID"
  #Insert appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo "I have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."

 }

DYE() {
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #echo "$PHONE_NUMBER"
  CUSTOMER_NAME=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  #echo "$CUSTOMER_NAME"
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    echo -e "\nPlease select an appointment time?"
    read SERVICE_TIME   
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo "$CUSTOMER_ID"
  #Insert appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

 } 

STYLE() {
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #echo "$PHONE_NUMBER"
  CUSTOMER_NAME=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  #echo "$CUSTOMER_NAME"
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    echo -e "\nPlease select an appointment time?"
    read SERVICE_TIME   
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL --username=freecodecamp --dbname=salon -c "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo "$CUSTOMER_ID"
  #Insert appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL --username=freecodecamp --dbname=salon -c "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

 }

EXIT() {
  echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU