*** Settings ***
Documentation       Test cases for user login

Resource            ../../resources/keywords/login_page.robot
Library             DataDriver    file=data/invalid_account.csv    encoding=utf_8    dialect=unix

Test Teardown       Close Browser
Test Template       Invalid Login Template

*** Test Cases ***
Login with user ${username} and password ${password} and expect error message ${error_message}    None    None    None


*** Keywords ***
Invalid Login Template
    [Arguments]    ${username}    ${password}    ${error_message}
    Open Login Page
    Enter Username    ${username}
    Enter Password    ${password}
    Click Login
    Should See Error Message    ${error_message}
