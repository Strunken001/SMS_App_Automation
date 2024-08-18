*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    ../shared/CustomKeywordsLibrary.py
Library    ../shared/PropertiesLibrary.py



*** Variables ***
${LOGIN_URL}    http://164.52.223.184/
${BROWSER}      Chrome
${CSV_FILE}     ../SMS_App_Automation/shared/resources/credentials.csv
${CONFIG_FILE}  ../SMS_App_Automation/shared/resources/smsconfig.properties
${file_path}    ../SMS_App_Automation/shared/resources/smsconfig.properties
${KEY_SENDER_ID}    sender_id
*** Test Cases ***
User Can Login Successfully

    ${credentials}    Read CSV File    ${CSV_FILE}
    ${random_credential}    Get Random Credential    ${credentials}
    ${username}=    Get From Dictionary    ${random_credential}    username
    ${password}=    Get From Dictionary    ${random_credential}    password
    Open Browser To Login Page
    Input Username And Password    ${username}    ${password}
    Submit Login Form
    Verify Login Success
    Click Element    xpath=//a[contains(@href, '/Management/ComposeSMS')]

    #Fill And Submit Form
    LoadProperties     ${file_path}
    ${sender_id}=   Get Key      sender_id
    ${contact_number}=  Get Key    contact_number
    ${message}=     Get Key    message
    ${auto_add_country_code}=   Get Key    auto_add_country_code
    ${remove_duplicate}=    Get Key    remove_duplicate
    Sleep    5
    Input Text    id=SenderId    ${sender_id}
    Input Text    id=ContactNumber    ${contact_number}
    Input Text    id=Message    ${message}
    Click Element    xpath=//div[contains(@class, 'form-group')]//label[contains(text(), 'Auto Add Country Code (91)')]/following-sibling::input[@type='checkbox']
    #Select Checkbox   id=RemoveDuplicateNumbers
    Send Form
    #Select Checkbox    xpath=//label[contains(text(), 'Auto Add Country Code (91)')]/following::input[@type='checkbox'][1]


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window

Input Username And Password
    [Arguments]    ${username}    ${password}
    Input Text    id=UserName    ${username}
    Input Text    id=Password    ${password}


Submit Login Form
    Click Button    xpath=//button[@type='submit']

Send Form
    Click Button    xpath=//button[@type='submit' and contains(text(), 'Send')]

Verify Login Success
    Wait Until Page Contains Element    xpath=//div[@class='Main_Menu']    10 seconds


Get From Dictionary
    [Arguments]    ${dictionary}    ${key}
    ${value}=    Evaluate    ${dictionary}[${key}]
    [Return]    ${value}



