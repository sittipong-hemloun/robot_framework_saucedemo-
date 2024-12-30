*** Settings ***
Library     SeleniumLibrary
Resource    ../variables/products_variable.robot
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
    # Example check - adapt the locator/message to your actual cart empty-state
    Run Keyword And Expect Error    *    Page Should Contain Element    xpath=//div[@class='inventory_item_name']
    Log    Cart is empty as expected.

Remove Item From Cart
    [Documentation]    Removes the specified product from the cart by clicking the Remove button
    [Arguments]    ${product_name}
    Click Element
    ...    xpath=//div[text()='${product_name}']/ancestor::div[@class='cart_item']//button[contains(@id, 'remove')]
