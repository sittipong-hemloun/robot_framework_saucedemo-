*** Settings ***
Documentation    Test case for valid login
Resource         ../../resources/keywords/login_page.robot

*** Test Cases ***
Valid User Can Login
    [Documentation]   Valid that a user can login with valid credentials
    Open Login Page
    Enter Username    standard_user
    Enter Password    secret_sauce
    Click Login
    Page Should Contain    Products
    [Teardown]    Close Browser

Invalid User Cannot Login
    [Documentation]   Valid that a user cannot login with invalid credentials
    Open Login Page
    Enter Username    invalid_user
    Enter Password    invalid_password
    Click Login
    Should See Error Message     Epic sadface: Username and password do not match any user in this service
    [Teardown]    Close Browser

