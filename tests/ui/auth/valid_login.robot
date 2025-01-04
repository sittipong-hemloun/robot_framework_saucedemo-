*** Settings ***
Documentation       Test cases for user login

Resource            ../../../resources/keywords/login_page.robot
Resource            ../../../resources/commons/variables/global_variables.robot


*** Test Cases ***
Valid Login Template
    Open Login Page
    Enter Username    ${VALID_USERNAME}
    Enter Password    ${VALID_PASSWORD}
    Click Login
    Close Browser
