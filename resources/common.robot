*** Settings ***
Library                         QForce
Library                         QVision
Library                         String


*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
${username_admin}               admin@dcs5.1v.com.51qa
${username_qa}                  quser@dcs5.1v.com.51qa
${password_admin}               Dotbcs00
${password_qa}                  Dotbcs00
${login_url}                    https://dcs51v--51qa.sandbox.lightning.force.com        # Salesforce instance. NoTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home
${BASE_IMAGE_PATH}



*** Keywords ***
Setup Browser
    # Setting search order is Not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb                        QVision
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    Evaluate                    random.seed()               random                      # initialize random generator


End suite
    Close All Browsers


Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username_admin}           delay=1
    TypeText                    Password                    ${password_admin}
    ClickText                   Log In
    # We'll check if variable ${secret} is given. If yes, fill the MFA dialog.
    # If Not, MFA is Not expected.
    # ${secret} is ${None} unless specifically given.
    ${MFA_needed}=              Run Keyword And Return Status                           Should Not Be Equal         ${None}                     ${secret}
    Run Keyword If              ${MFA_needed}               Fill MFA


Login As
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickText                   Setup for current app
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickText                   User                        anchor=${persona}           delay=5                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               delay=1


Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.                              2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce


    # Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]             Verifies that stage given in ${text} is at ${selected} state; either selected (true) or Not selected (false)
    [Arguments]                 ${text}                     ${selected}=true
    VerifyElement               //a[@title\="${text}" and (@aria-checked\="${selected}" or @aria-selected\="${selected}")]


NoData
    VerifyNoText                ${data}                     timeout=3                   delay=2

Policy
    [Documentation]             create a master doument type Policy
    LaunchApp                   Master Documents
    Sleep                       5
    Click New Master Document type Controlled
    TypeText                    *Document Name              TempTest1
    PickList                    *Document Type              Policy
    PickList                    Document Sub Type           Validation Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ClickCheckbox               Is Template                 on
    ComboBox                    Search Departments...       test
    ClickText                   Save                        partial_match=False
    #uplode file

Appendix
    [Documentation]             create a master doument type Appendix
    TypeText                    *Document Name              OQ1MD1 test7
    PickList                    *Document Type              Appendix
    PickList                    *Business Unit              General
    ComboBox                    Search Departments...       test
    ClickText                   Save                        partial_match=False

Worksheet
    [Documentation]             create a master doument type Worksheet
    LaunchApp                   Master Documents
    Sleep                       5
    Click New Master Document type Controlled
    TypeText                    *Document Name              OQ1MD1 test7
    PickList                    *Document Type              Worksheet
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       test
    ClickText                   Save                        partial_match=False
    VerifyText                  WKS                         anchor=Master Document Number


Protocol
    [Documentation]             create a master doument type Protocol
    LaunchApp                   Master Documents
    Sleep                       5
    Click New Master Document type Controlled
    TypeText                    *Document Name              OQ1MD1 test7
    PickList                    *Document Type              Protocol                    anchor=Document Type
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       test
    ClickText                   Save                        partial_match=False
    VerifyText                  PRT                         anchor=Master Document Number


Click New Master Document type Controlled 
    ClickText                   New                         anchor=Import
    Verify Dialog Title New Master Document
    ClickText                   Next

Click New Master Document type Simple 
    ClickText                   New                         anchor=Import
    Verify Dialog Title New Master Document
    ClickText                   Simple
    ClickText                   Next

Verify Dialog Title New Master Document
    Use Modal                   On
    VerifyText                  New Master Document
    Use Modal                   Off

verify the fields are required
    ClickText                   Save                        partial_match=False
    VerifyText                  Document Name               anchor=Review the following fields
    VerifyText                  Document Type               anchor=Review the following fields
    VerifyText                  Business Unit               anchor=Review the following fields
    verify text                 Department                  anchor=Review the following fields
Cancel the record
    ClickText                   Cancel
    TypeText                    Comments                    test
    ClickText                   Next
Sign with admin    
    TypeText                    User                        ${username_admin}           delay=1
    TypeText                    User Password               ${password_admin}
    ClickText                   Sign                        anchor=Cancel
