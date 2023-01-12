#!/bin/bash

PSQL="psql -U freecodecamp -d salon --tuples-only --csv --command"

readarray -t AVAILABLE_SERVICES <<<"$($PSQL "SELECT service_id FROM services")"

SERVICE_EXISTS() {
  for s in "${AVAILABLE_SERVICES[@]}"; do
    if [[ $s == $1 ]]; then
      echo "$s"
    fi
  done
}

DISPLAY_SERVICES() {
  {
    while IFS=, read SERVICE_ID SERVICE_NAME; do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
  } <<<"$($PSQL "SELECT * FROM services")"

}

MAKE_APPOINTMENT() {
  # enter service_id
  echo -e "\nPlease choose a service from list below:"
  DISPLAY_SERVICES
  read SERVICE_ID_SELECTED
  while [[ -z $(SERVICE_EXISTS $SERVICE_ID_SELECTED) ]]; do
    echo -e "\nThat service does not exist, please choose again:"
    DISPLAY_SERVICES
    read SERVICE_ID_SELECTED
  done
  # enter phone number
  echo -e "\nPlease enter the customer's phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_NAME="$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")"
  # if not already a customer
  if [[ -z $CUSTOMER_NAME ]]; then
    # enter a name
    echo -e "\nPhone number not present in database, please enter customer name:"
    read CUSTOMER_NAME
    # insert customer into database
    INSERTED_CUSTOMER_RESULT="$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")"
  fi

  # enter a time
  echo -e "\nEnter the service time for the appointment:"
  read SERVICE_TIME

  # create appointment
  SELECTED_CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")"
  SELECTED_SERVICE="$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")"
  echo -e "\nCreating appointment:"
  INSERTED_APPOINTMENT_RESULT="$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($SELECTED_CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")"
  echo -e "I have put you down for a $SELECTED_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."

}

EXIT() {
  echo "Exit Program"
}

MAKE_APPOINTMENT
