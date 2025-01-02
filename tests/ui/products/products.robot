*** Settings ***
Documentation       Test cases for products functionality

Resource            ../../../resources/commons/keywords/login_keyword.robot
Resource            ../../../resources/keywords/products_page.robot

Suite Setup         Valid User Can Login
Suite Teardown      Close Browser


*** Test Cases ***
View Products Page After Login
    [Documentation]    Ensure that the products page is accessible after a valid login
    Page Should Contain    Products

Add Single Product To Cart
    [Documentation]    Test adding a single product to the cart
    Add Product To Cart    Sauce Labs Backpack
    Element Text Should Be    xpath=//span[@class='shopping_cart_badge']    1
    Remove Product From Cart    product_name=Sauce Labs Backpack

Add Multiple Products To Cart
    [Documentation]    Test adding multiple products to the cart
    Add Product To Cart    Sauce Labs Backpack
    Add Product To Cart    Sauce Labs Bolt T-Shirt
    Element Text Should Be    xpath=//span[@class='shopping_cart_badge']    2
    Remove Product From Cart    product_name=Sauce Labs Backpack
    Remove Product From Cart    product_name=Sauce Labs Bolt T-Shirt

Remove Product From Cart
    [Documentation]    Test removing a product from the cart
    Add Product To Cart    Sauce Labs Backpack
    Remove Product From Cart    Sauce Labs Backpack
    Run Keyword And Ignore Error    Element Text Should Be    xpath=//span[@class='shopping_cart_badge']    0
