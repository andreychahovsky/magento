*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser    https://www.google.com/    chrome
Test Teardown    Close Browser

*** Variables ***
${BROWSER}    chrome
${BASE_URL}    https://www.google.com/
${create_acc_url}    https://magento.softwaretestingboard.com/customer/account/create/
${login_url}    https://magento.softwaretestingboard.com/customer/account/login/
${logout_url}    https://magento.softwaretestingboard.com/customer/account/logout/
${bags_url}    https://magento.softwaretestingboard.com/gear/bags.html
${cart_url}    https://magento.softwaretestingboard.com/checkout/cart/
${first_name}    Vasia
${last_name}    Pupkin
${email}    vasia@pupkin.com
${password}    password-1

*** Test Cases ***
Magento
    Maximize Browser Window
    Set Selenium Implicit Wait    30 seconds
    # Create An Account    ${first_name}    ${last_name}    ${email}    ${password}
    # Logout
    Login    ${email}    ${password}
    Add Items To Cart
    Modifier Cart
    Logout

*** Keywords ***
# Create An Account
#     [Arguments]    ${first_name}    ${last_name}    ${email}    ${password}
#     Go To    ${create_acc_url}
#     Input Text    id=firstname    ${first_name}
#     Input Text    id=lastname    ${last_name}
#     Input Text    id=email_address    ${email}
#     Input Password    id=password    ${password}
#     Input Password    id=password-confirmation    ${password}
#     Set Selenium Implicit Wait    5 seconds
#     Click Element    xpath://form[@id='form-validate']/div/div/button/span

Logout
    Go To    ${logout_url}
    Sleep    30 seconds

Login
    [Arguments]    ${email}    ${password}
    Go To    ${login_url}
    Sleep    10 seconds
    Input Text    id=email    ${email}
    Input Text    id=pass    ${password}
    Click Button    id=send2

Add Items To Cart
    Go To    ${bags_url}
    Click Element    xpath://*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[7]
    Click Button    id=product-addtocart-button
    Sleep    5 seconds

    Go To    ${bags_url}
    Click Element    xpath://*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[4]
    Click Button    id=product-addtocart-button
    Sleep    5 seconds

    Go To    ${cart_url}
    Sleep    5 seconds
    ${cart_items}    Get WebElements    xpath://tr[@class="item-info"]
    ${item_count}    Get Length    ${cart_items}
    Should Be Equal As Numbers    ${item_count}    2    "Checking add\nI was waiting that in the cart 2 elements, yet there are ${item_count}"

Modifier Cart
    Go To    ${cart_url}
    Sleep    5 seconds
    # check that total price
    ${price_before}    Get Text    xpath://tr[@class="grand totals"]/td/strong/span
    # check qty de items
    ${firs_item_qty}    Get Element Attribute    locator=xpath://div[@class="control qty"]/label/input    attribute=value

    # Remove item
    Click Element    xpath://*[@id="shopping-cart-table"]/tbody/tr[2]/td/div/a[3]

    Sleep    5 seconds
    ${price_after}    Get Text    xpath://tr[@class="grand totals"]/td/strong/span
    # ${price_after}    Get Text    xpath://span[@class="price"]
    Sleep    5 seconds
    Should Not Be Equal As Strings    first=${price_before}    second=${price_after}    msg="Price is not changed..."

    

    Sleep    5 seconds
    ${cart_items}    Get WebElements    xpath://tr[@class="item-info"]
    ${item_count}    Get Length    ${cart_items}
    Should Be Equal As Numbers    ${item_count}    1    "Checking modify\nI was waiting that in the cart 1 elements, yet there are ${item_count}"

    # Clear the cart for the future
    Sleep    5 seconds
    # Click Element    xpath://a[@title="Remove item"]
    Click Element    xpath://*[@id="shopping-cart-table"]/tbody/tr[2]/td/div/a[3]