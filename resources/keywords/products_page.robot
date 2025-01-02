*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/products_variable.robot


*** Keywords ***
Add Product To Cart
    [Arguments]    ${product_name}
    ${product}=    Get WebElement    xpath=//div[normalize-space()='${product_name}']
    ${product_name_lowercase}=    Set Variable    ${product_name.replace(' ', '-').lower()}
    Click Button    xpath=//button[@id='add-to-cart-${product_name_lowercase}']

Add Product By Include Text In Name
    [Arguments]    ${product_name}
    ${product}=    Get WebElement
    ...    xpath=//div[contains(@class, 'inventory_item_name') and contains(text(), '${product_name}')]
    Log    ${product}
    ${product_name_lowercase}=    Set Variable    ${product_name.replace(' ', '-').lower()}
    Click Button    xpath=//button[@id='add-to-cart-${product_name_lowercase}']

Add Product To Cart If Found
    [Documentation]    Tries to add ${product_name} to the cart. If not found, logs a warning and continues.
    [Arguments]    ${product_name}
    Run Keyword And Ignore Error    Add Product To Cart    ${product_name}
    ${err}=    Run Keyword And Return Status
    ...    Page Should Contain Element
    # ...    xpath=//div[@class='inventory_item_name' and text()='${product_name}']
    ...    xpath=//div[contains(@class, 'inventory_item_name') and contains(text(), '${product_name}')]
    IF    '${err}' == 'False'
        Log    WARNING: Product "${product_name}" was not found and could not be added.    WARN
    END

Remove Product From Cart
    [Arguments]    ${product_name}
    Click Button    xpath=//button[@id='remove-${product_name.replace(' ', '-').lower()}']

Remove Product From Cart If Found
    [Documentation]    Tries to remove ${product_name}. If not found, logs a warning and continues.
    [Arguments]    ${product_name}
    Run Keyword And Ignore Error    Remove Product From Cart    ${product_name}
    ${err}=    Run Keyword And Return Status
    ...    Page Should Contain Element
    ...    xpath=//div[@class='inventory_item_name' and text()='${product_name}']
    IF    '${err}' == 'False'
        Log    Product "${product_name}" is not in the cart or has been removed already.    INFO
    ELSE
        Log    WARNING: Product "${product_name}" is still found in the cart.    WARN
    END

Verify Product Is In Cart
    [Arguments]    ${product_name}
    Page Should Contain Element    xpath=//div[@class='inventory_item_name' and text()='${product_name}']
