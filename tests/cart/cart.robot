*** Settings ***
Documentation       Test cases for cart functionality

Resource            ../../resources/commons/keywords/login_keyword.robot
Resource            ../../resources/keywords/products_page.robot
Resource            ../../resources/keywords/cart_page.robot

Test Setup         Valid User Can Login
Suite Teardown      Close Browser


*** Test Cases ***
Open Cart Page Successfully
    [Documentation]    Ensure the cart page opens with no errors
    Open Cart Page
    Title Should Be    Swag Labs
    # Optionally verify something unique on the cart page
    Log    "Cart page opened successfully."

Verify Cart Is Empty By Default
    [Documentation]    Checks the cart is empty when no products have been added
    Open Cart Page
    Verify Cart Is Empty

Add Single Item And Verify In Cart
    [Documentation]    Add a single product, then open the cart and verify its presence
    Add Product To Cart    Sauce Labs Backpack
    Open Cart Page
    Verify Cart Contains Item    Sauce Labs Backpack

Add Multiple Items And Verify In Cart
    [Documentation]    Add multiple products, then verify they are in the cart
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Open Cart Page
    Verify Cart Contains Item    Sauce Labs Backpack
    Verify Cart Contains Item    Sauce Labs Bolt T-Shirt

Remove Single Item From Cart
    [Documentation]    Add and then remove an item, verifying removal
    Add Product To Cart    Sauce Labs Fleece Jacket
    Open Cart Page
    Verify Cart Contains Item    Sauce Labs Fleece Jacket
    Remove Item From Cart    Sauce Labs Fleece Jacket
    Run Keyword And Expect Error    *    Verify Cart Contains Item    Sauce Labs Fleece Jacket
    Log    "Item removed successfully."

Empty Cart Scenario
    [Documentation]    Add multiple items, remove them all, and verify cart is empty
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Add Product To Cart    Sauce Labs Onesie
    Open Cart Page
    Remove Item From Cart    Sauce Labs Backpack
    Remove Item From Cart    Sauce Labs Bolt T-Shirt
    Remove Item From Cart    Sauce Labs Onesie
    Verify Cart Is Empty
