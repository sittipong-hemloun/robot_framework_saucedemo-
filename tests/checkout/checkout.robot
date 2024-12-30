*** Settings ***
Documentation       Test cases for the checkout process

Resource            ../../resources/commons/login_keyword.robot
Resource            ../../resources/keywords/products_page.robot
Resource            ../../resources/keywords/cart_page.robot
Resource            ../../resources/keywords/checkout_page.robot

Suite Setup         Login And Add Item To Cart
Suite Teardown      Close Browser


*** Variables ***
${FIRST_NAME}       John
${LAST_NAME}        Doe
${ZIP_CODE}         12345


*** Test Cases ***
Begin Checkout Flow
    [Documentation]    Validate that we can navigate from cart to checkout
    Open Cart Page
    Click Checkout
    Page Should Contain Element    ${FIRST_NAME_FIELD}

Enter Shipping Information
    [Documentation]    Enter required info and proceed to the overview page
    Enter Checkout Information    ${FIRST_NAME}    ${LAST_NAME}    ${ZIP_CODE}
    Click Continue
    Verify Checkout Overview Page

Finish Checkout
    [Documentation]    Complete the order and validate success
    Click Finish
    Verify Checkout Complete


*** Keywords ***
Login And Add Item To Cart
    [Documentation]    Reusable for suite setup
    Valid User Can Login
    Add Product To Cart    Sauce Labs Backpack
