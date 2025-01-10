*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/global_variables.robot

*** Keywords ***
Open Browser And Navigate
    [Arguments]    ${url}
    ${driver_path}=    Set Variable    ${CURDIR}/../../../drivers/${BROWSER}driver
    Open Browser    ${url}    ${BROWSER}    executable_path=${driver_path}
    Maximize Browser Window

Close Browser Session
    Close Browser
