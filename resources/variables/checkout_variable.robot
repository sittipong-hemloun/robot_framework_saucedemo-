*** Variables ***
${CHECKOUT_BUTTON}                  xpath=//button[@id='checkout']
${FIRST_NAME_FIELD}                 xpath=//input[@id='first-name']
${LAST_NAME_FIELD}                  xpath=//input[@id='last-name']
${ZIP_FIELD}                        xpath=//input[@id='postal-code']
${CONTINUE_BUTTON}                  xpath=//input[@id='continue']
${FINISH_BUTTON}                    xpath=//button[@id='finish']
${CHECKOUT_COMPLETE_HEADER}         xpath=//h2[@class='complete-header']
${CHECKOUT_COMPLETE_TEXT}           xpath=//div[@class='complete-text']

# Optional messages depending on the site’s design
${CHECKOUT_COMPLETE_EXPECTED}       Thank you for your order!
${CHECKOUT_TEXT_EXPECTED}           Your order has been dispatched
