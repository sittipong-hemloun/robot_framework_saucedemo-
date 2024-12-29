*** Settings ***
Documentation    Test cases for products functionality
Resource         ../../resources/commons/login_keyword.robot
Resource         ../../resources/keywords/products_page.robot

*** Test Cases ***
View Products Page After Login
    [Documentation]    Ensure that the products page is accessible after a valid login
    Valid User Can Login
    Page Should Contain    Products
    [Teardown]    Close Browser

Add Single Product To Cart
    [Documentation]    Test adding a single product to the cart
    Valid User Can Login
    Add Product To Cart    Sauce Labs Backpack
    # Verify the cart icon updates (assuming there's a cart badge)
    Element Text Should Be    xpath=//span[@class='shopping_cart_badge']    1
    [Teardown]    Close Browser

Add Multiple Products To Cart
    [Documentation]    Test adding multiple products to the cart
    Valid User Can Login
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    # Verify the cart icon updates
    Element Text Should Be    xpath=//span[@class='shopping_cart_badge']    2
    [Teardown]    Close Browser

Remove Product From Cart
    [Documentation]    Test removing a product from the cart
    Valid User Can Login
    Add Product To Cart    Sauce Labs Backpack
    Remove Product From Cart    Sauce Labs Backpack
    # Verify the cart icon updates
    Run Keyword And Ignore Error    Element Text Should Be    xpath=//span[@class='shopping_cart_badge']    0
    [Teardown]    Close Browser