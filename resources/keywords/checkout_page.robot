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

Verify 8 Percent Tax
    [Documentation]    Captures item total and tax from the overview page. Ensures the displayed tax is 8%.
    [Arguments]    ${expected_tax_rate}
    ${item_total_text}=    Get Text    xpath=//div[@class='summary_subtotal_label']
    # Example: item_total_text might be "Item total: $31.98"
    ${item_total}=    Evaluate    re.search(r'[0-9]+\\.[0-9]+', '''${item_total_text}''').group(0)    re
    ${item_total}=    Convert To Number    ${item_total}

    ${tax_text}=    Get Text    xpath=//div[@class='summary_tax_label']
    # Example: tax_text might be "Tax: $2.56"
    ${tax_amount}=    Evaluate    re.search(r'[0-9]+\\.[0-9]+', '''${tax_text}''').group(0)    re
    ${tax_amount}=    Convert To Number    ${tax_amount}

    ${expected_tax}=    Evaluate    ${item_total} * ${EXPECTED_TAX_RATE}
    Should Be Equal As Numbers
    ...    ${tax_amount}
    ...    ${expected_tax}
    ...    msg=Tax is not 8% of the item total.
    ...    precision=0.01

    Log    Verified that tax is 8% of ${item_total} ( => ${tax_amount} ).
