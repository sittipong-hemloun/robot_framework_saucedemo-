*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/login_variable.robot


*** Keywords ***
Open Login Page
    [Documentation]    Navigate to the login page
    Go To    ${URL}

Enter Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Click Login
    Click Button    ${LOGIN_BUTTON}

Should See Error Message
    [Arguments]    ${message}
    Element Should Contain    ${ERROR_MESSAGE}    ${message}