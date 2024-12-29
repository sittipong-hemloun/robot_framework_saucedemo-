*** Settings ***
Library    SeleniumLibrary
Resource    ../variables/products_variable.robot

*** Keywords ***
Add Product To Cart
    [Arguments]    ${product_name}
    ${product}=    Get WebElement    xpath=//div[normalize-space()='${product_name}']
    ${product_name_lowercase}=    Set Variable    ${product_name.replace(' ', '-').lower()}
    Click Button    xpath=//button[@id='add-to-cart-${product_name_lowercase}']

Remove Product From Cart
    [Arguments]    ${product_name}
    Click Button    xpath=//button[@id='remove-${product_name.replace(' ', '-').lower()}']

Verify Product Is In Cart
    [Arguments]    ${product_name}
    Page Should Contain Element    xpath=//div[@class='inventory_item_name' and text()='${product_name}']