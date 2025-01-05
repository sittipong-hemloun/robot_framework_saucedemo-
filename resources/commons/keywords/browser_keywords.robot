*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Browser And Navigate
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window

Close Browser Session
    Close Browser