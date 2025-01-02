*** Settings ***
Documentation       This is a smoke test suite that demonstrates a simple workflow:
...                 1) Login
...                 2) Add products to cart (T-Shirt, flashlight, Backpack)
...                 3) Remove Backpack from the cart
...                 4) Checkout
...                 5) Verify that tax is calculated at 8%
...                 6) Confirm order completion
...                 7) Log results

Library             Collections
Library             JSONLibrary
Library             SeleniumLibrary
Resource            ../../resources/commons/keywords/browser_keywords.robot
Resource            ../../resources/commons/keywords/login_keyword.robot
Resource            ../../resources/keywords/products_page.robot
Resource            ../../resources/keywords/cart_page.robot
Resource            ../../resources/keywords/checkout_page.robot

Suite Teardown      Close Browser


*** Variables ***
${CONFIG_FILE_PATH}     resources/config/product_list.json
${FIRST_NAME}           Sittipong
${LAST_NAME}            Hemloun
${ZIP_CODE}             20130
${EXPECTED_TAX_RATE}    0.08


*** Test Cases ***
Smoke Test - Purchase Flow
    [Documentation]    High-level smoke test that verifies the user can:
    ...    1) Login
    ...    2) Add specific products
    ...    3) Remove one product
    ...    4) Proceed with checkout
    ...    5) Verify 8% tax
    ...    6) Confirm successful order

    Log To Console    -- Step 1: Login --
    Valid User Can Login

    Log To Console    -- Step 2: Add Products (T-Shirt, flashlight, Backpack) --
    ${product_data}=    Load JSON From File    ${CONFIG_FILE_PATH}
    Log    ${product_data}
    ${products}=    Get Value From Json    ${product_data}    $.products
    Log    ${products[0]}
    FOR    ${product}    IN    @{products[0]}
        Log    Adding product: ${product}
        Add Product To Cart If Found    ${product}
    END

    Log To Console    -- Step 3: Remove Backpack --
    Remove Product From Cart If Found    Sauce Labs Backpack

    Log To Console    -- Step 4: Begin Checkout --
    Open Cart Page
    Click Checkout
    Enter Checkout Information    ${FIRST_NAME}    ${LAST_NAME}    ${ZIP_CODE}
    Click Continue
    Verify Checkout Overview Page

    Log To Console    -- Step 5: Verify Tax is 8% --
    Verify 8 Percent Tax    ${EXPECTED_TAX_RATE}

    Log To Console    -- Step 6: Finish Checkout and Confirm Order --
    Click Finish
    Verify Checkout Complete

    Log To Console    -- Step 7: Log results --
    Log    Smoke test completed successfully.
