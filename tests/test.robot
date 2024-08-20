*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    ../shared/CustomKeywordsLibrary.py
Library    ../shared/PropertiesLibrary.py
Library    ../shared/CredentialsReader.py


*** Variables ***
${LOGIN_URL}    http://164.52.223.184/
${BROWSER}      Chrome
${CREDENTIALS_FILE}     ../SMS_App_Automation/shared/resources/credentials.csv
${WORKSPACE}
${CONFIG_FILE}  ${WORKSPACE}/shared/resources/smsconfig.properties
${file_path}    ../SMS_App_Automation/shared/resources/smsconfig.properties
${KEY_SENDER_ID}    sender_id
*** Test Cases ***
User Can Login Successfully

        ${config}=    Read Config    ${CONFIG_FILE}
        Log    ${config}
        FOR    ${i}    IN RANGE    4
            Open Browser To Login Page
            Load Credentials
            ${credential}    Get Next Credential
            Log    Username: ${credential['username']} Password: ${credential['password']}

            Perform Login    ${credential['username']}    ${credential['password']}
            Submit Login Form
            Verify Login Success
            Click Element    xpath=//a[contains(@href, '/Management/ComposeSMS')]

             #Fill And Submit Form
             LoadProperties     ${file_path}
             ${sender_id}=   Get Key      sender_id
             ${contact_number}=  Get Key    contact_number
             ${message}=     Get Key    message

             Sleep    5
             Input Text    id=SenderId    ${sender_id}
             Input Text    id=ContactNumber    ${contact_number}
             Input Text    id=Message    ${message}
             Send Form

             Sleep    5

             Click Element    xpath=//div[contains(@class, 'modal-footer')]//button[contains(text(), 'Send')]
             Close Browser
        END



*** Keywords ***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    #Call Method    ${options}    add_argument    --window-size=1920,1080
    Open Browser    ${LOGIN_URL}    ${BROWSER}  options=${options}

    Maximize Browser Window


Submit Login Form
    Click Button    xpath=//button[@type='submit']

Send Form
    Click Button    xpath=//button[@type='submit' and contains(text(), 'Send')]

Verify Login Success
    Wait Until Page Contains Element    xpath=//div[@class='Main_Menu']    10 seconds



Perform Login
    [Arguments]    ${username}    ${password}
    # Your login logic here
    Input Text    id=UserName    ${username}
    Input Text    id=Password    ${password}

Read Config
    [Arguments]    ${path}
    ${content}=    Get File    ${path}
    [Return]    ${content}




