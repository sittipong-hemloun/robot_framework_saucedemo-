*** Settings ***
Documentation       Test cases for user login

Resource            ../../resources/keywords/login_page.robot


*** Test Cases ***
valid Login Template
    Open Login Page
    Enter Username    standard_user
    Enter Password    secret_sauce
    Click Login
    Close Browser
