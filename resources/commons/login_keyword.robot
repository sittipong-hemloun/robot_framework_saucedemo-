*** Settings ***
Library     SeleniumLibrary
Resource    ../keywords/login_page.robot

*** Variables ***
${VALID_USERNAME}    standard_user
${VALID_PASSWORD}    secret_sauce

*** Keywords ***
Valid User Can Login
    [Documentation]    Log in with valid credentials
    Open Login Page
    Enter Username    ${VALID_USERNAME}
    Enter Password    ${VALID_PASSWORD}
    Click Login
