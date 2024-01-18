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
SauceLab Test
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
#     Click Element    xpath=//form[@id='form-validate']/div/div/button/span

Logout
    Go To    ${logout_url}
    Set Selenium Implicit Wait    30 seconds

Login
    [Arguments]    ${email}    ${password}
    Go To    ${login_url}
    Set Selenium Implicit Wait    10 seconds
    Input Text    id=email    ${email}
    Input Text    id=pass    ${password}
    Click Button    id=send2

Add Items To Cart
    Go To    ${bags_url}
    Click Element    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[7]
    Click Button    id=product-addtocart-button
    Set Selenium Implicit Wait    5 seconds
    Sleep    5 seconds

    Go To    ${bags_url}
    Click Element    xpath=//*[@id="maincontent"]/div[3]/div[1]/div[4]/ol/li[4]
    Click Button    id=product-addtocart-button
    Set Selenium Implicit Wait    5 seconds
    Sleep    5 seconds

    # Go To    ${cart_url}
    # ${cart_items}    Get WebElements    xpath=//*[@id="shopping-cart-table"]
    # ${item_count}    Get Length    ${cart_items}
    # Should Be Equal As Numbers    ${cart_items}    2    "I was waiting that in the cart 2 elements, yet there are ${item_count}"

Modifier Cart
    Go To    ${cart_url}
    Click Element    xpath=//*[@id="shopping-cart-table"]/tbody/tr[2]/td/div/a[3]
    # ${cart_items}    Get WebElements    xpath=//*[@id="shopping-cart-table"]
    # ${item_count}    Get Length    ${cart_items}
    # Should Be Equal As Numbers    ${cart_items}    1    "I was waiting that in the cart 1 elements, yet there are ${item_count}"