*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/cart_variable.robot


*** Keywords ***
Open Cart Page
    [Documentation]    Navigate to the cart page by clicking the cart icon or link
    Click Element    ${CART_ICON}

Verify Cart Contains Item
    [Documentation]    Ensures the specified product is listed in the cart
    [Arguments]    ${product_name}
    Page Should Contain Element    xpath=//div[@class='inventory_item_name' and text()='${product_name}']

Verify Cart Is Empty
    [Documentation]    Checks if the cart has no items or if an empty state message is shown
    Page Should Contain Element    ${EMPTY_CART_MESSAGE}
    Element Text Should Be    ${EMPTY_CART_MESSAGE}    ${CART_EMPTY_TEXT}

Remove Item From Cart
    [Documentation]    Removes the specified product from the cart by clicking the Remove button
    [Arguments]    ${product_name}
    Click Element
    ...    xpath=//div[text()='${product_name}']/ancestor::div[@class='cart_item']//button[contains(@id, 'remove')]
