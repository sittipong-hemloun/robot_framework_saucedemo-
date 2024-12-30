*** Settings ***
Library     SeleniumLibrary
Resource    ../keywords/login_page.robot
Resource    ../commons/global_variables.robot

*** Keywords ***
Valid User Can Login
    [Documentation]    Log in with valid credentials
    Open Login Page
    Enter Username    ${VALID_USERNAME}
    Enter Password    ${VALID_PASSWORD}
    Click Login
