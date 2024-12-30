*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/checkout_variable.robot


*** Keywords ***
Click Checkout
    [Documentation]    Clicks the 'Checkout' button on the Cart page
    Click Button    ${CHECKOUT_BUTTON}

Enter Checkout Information
    [Documentation]    Fills in shipping/payment info
    [Arguments]    ${first_name}    ${last_name}    ${zip_code}
    Input Text    ${FIRST_NAME_FIELD}    ${first_name}
    Input Text    ${LAST_NAME_FIELD}    ${last_name}
    Input Text    ${ZIP_FIELD}    ${zip_code}

Click Continue
    [Documentation]    Proceeds from Step One to Step Two of the checkout
    Click Button    ${CONTINUE_BUTTON}

Verify Checkout Overview Page
    [Documentation]    Verifies user is on the Overview page
    Page Should Contain Element    ${FINISH_BUTTON}    # indicates overview screen is displayed

Click Finish
    [Documentation]    Finalizes the checkout process
    Click Button    ${FINISH_BUTTON}

Verify Checkout Complete
    [Documentation]    Checks the final confirmation message/page
    Page Should Contain Element    ${CHECKOUT_COMPLETE_HEADER}
    Element Text Should Be    ${CHECKOUT_COMPLETE_HEADER}    ${CHECKOUT_COMPLETE_EXPECTED}
    Page Should Contain Element    ${CHECKOUT_COMPLETE_TEXT}
    Element Should Contain    ${CHECKOUT_COMPLETE_TEXT}    ${CHECKOUT_TEXT_EXPECTED}
