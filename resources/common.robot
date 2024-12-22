*** Settings ***
Library                         QForce
Library                         String


*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
${username_admin}               admin@oq53val.com
${username_qa}                  quser@xp53beta21.com
${password_admin}               Dotbcs00
${password_qa}                  Dotbcs00
${login_url}                    https://oq53val.my.salesforce.com        # Salesforce instance. NoTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home
${BASE_IMAGE_PATH}



*** Keywords ***
Setup Browser
    # Setting search order is Not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    Evaluate                    random.seed()               random                      # initialize random generator
    Login
    


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

 Create simple name  
    ${SMD_Name_1}=              Generate Random String      4                           [NUMBERS]
    ${SMD_Name_2}=              Catenate                    Simple BC                   ${SMD_Name_1}
    TypeText                    *Document Name              ${SMD_Name_2}

 Create Controlled name  
    ${CMD_Name_1}=              Generate Random String      4                           [NUMBERS]
    ${CMD_Name_2}=              Catenate                    Controlled BC               ${CMD_Name_1}
    TypeText                    *Document Name              ${CMD_Name_2}

Create Promotional Materials name  
    ${CMD_Name_1}=              Generate Random String      4                           [NUMBERS]
    ${CMD_Name_2}=              Catenate                    PromoMats BC               ${CMD_Name_1}
    TypeText                    *Document Name              ${CMD_Name_2}

Create training effective name
    ${TE_Name_1}=               Generate Random String      4                           [NUMBERS]
    ${TE_Name_2}=               Catenate                    Controlled BC               ${TE_Name_1}
    TypeText                    *Protocol Name              ${TE_Name_2}
    
    [Documentation]             create a master doument type Policy
    LaunchApp                   Master Documents
    Sleep                       5
    Click New Master Document type Controlled
    Create Controlled name
    PickList                    *Document Type              Policy
    PickList                    Document Sub Type           Validation Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ClickCheckbox               Is Template                 on
    ComboBox                    Search Departments...       test
    save the record


Appendix
    [Documentation]             create a master doument type Appendix
    Create simple name
    PickList                    *Document Type              Appendix
    PickList                    *Business Unit              General
    ComboBox                    Search Departments...       test
    save the record

Worksheet
    [Documentation]             create a master doument type Worksheet
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    Create Controlled name
    PickList                    *Document Type              Worksheet
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       test
    save the record
    VerifyText                  WKS                         anchor=Master Document Number



Protocol
    [Documentation]             create a master doument type Protocol
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    Create Controlled name
    PickList                    *Document Type              Protocol                    anchor=Document Type
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       test
    save the record
    VerifyText                  PRT                         anchor=Master Document Number


Click New Master Document type Controlled 
    ClickText                   New                         anchor=Import               delay=5s
    Verify Dialog Title New Master Document
    ClickText                   Next

Click New Master Document type Simple 
    ClickText                   New                         anchor=Import               delay=5s
    Verify Dialog Title New Master Document
    ClickText                   Simple                      anchor=Document which require approval within the quality system
    ClickText                   Next

Click New Master Document type Promotional Materials 
    ClickText                   New                         anchor=Import               delay=5s
    Verify Dialog Title New Master Document
    ClickText                   Promotional Materials
    ClickText                   Next

Verify Dialog Title New Master Document
    Use Modal                   On
    VerifyText                  New Master Document
    Use Modal                   Off

verify the fields are required for simple
    save the record
    VerifyText                  Document Name               anchor=Review the following fields                      delay=3s
    VerifyText                  Document Type               anchor=Review the following fields
    VerifyText                  Business Unit               anchor=Review the following fields
    verify text                 Department                  anchor=Review the following fields

verify the fields are required for Controlled
    save the record
    VerifyText                  Document Name               anchor=Review the following fields                      delay=2s
    VerifyText                  Document Type               anchor=Review the following fields
    VerifyText                  Business Unit               anchor=Review the following fields
    verify text                 Department                  anchor=Review the following fields                      delay=3s
    VerifyText                  Is this a Form or Translation?                          anchor=Review the following fields

Sign with admin    
    TypeText                    User                        ${username_admin}           delay=1s
    TypeText                    User Password               ${password_admin}
    ClickText                   Sign                        anchor=Cancel

 required field for Cancel and Re-Open
    ClickText                   Next                        delay=3s
    VerifyText                  The following fields are mandatory in order to promote the record state. Please populate the fields and save in order to continue.    delay=3s

save the record
    ClickText                   Save                        partial_match=False         delay=3s

promote simpel record to effective
    ClickText                   Actions
    ClickText                   Approve
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin User
    ClickText                   Next
    VerifyText                  E-Signature for Approve
    Sign with admin

Navigate to Master Document
    ClickElement                (//div[@class\='slds-grid'])                            timeout=10                  delay=5s


Navigate to Document Revision
    ClickElement                (//span[@title\='Document Revision'])                   timeout=10                  delay=3s


promote Controlled record to effective
    ClickText                   Actions                     delay=5s
    ClickText                   Send for Review
    VerifyText                  Select Signatories for Revision Review
    ClickItem                   checkbox                    anchor=Admin User           partial_match=False
    ClickText                   Next                        partial_match=False         delay=3s
    ClickItem                   checkbox                    anchor=Admin User           partial_match=False         delay=3s
    ClickText                   Next                        partial_match=False
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin User
    ClickText                   Next
    VerifyText                  E-Signature for Send for Review
    Sign with admin
    ClickText                   Actions                     partial_match=False         delay=12s
    HoverText                   Pending Review              delay=2s
    ClickText                   Sign
    Wait Until Keyword Succeeds                             60                          5                           Sign with admin
    ClickText                   Actions                     partial_match=False         delay=12s
    ClickText                   Send For Approval
    Wait Until Keyword Succeeds                             60                          5                           Sign with admin
    ClickText                   Actions                     partial_match=False         delay=12s
    ClickText                   Start Approval
    Wait Until Keyword Succeeds                             60                          5                           Sign with admin
    ClickText                   Actions
    ClickText                   QA Approval - Skip Training                             partial_match=False         delay=12s
    TypeText                    Comments                    test
    ClickText                   Next
    VerifyText                  E-Signature for QA Approval
    Wait Until Keyword Succeeds                             60                          5                           Sign with admin


    # Enter Form New Protocol Electronic Form Protocol

    #                           [Documentation]             Use this keyword to enter the entire form, first arguments are mandatory fields followed by optional ones
    #                           ...                         checkbox accepts argument value on or off
    #                           [Arguments]                 ${protocol_name}            ${business_unit}            ${protocol_execution_style}    ${additional_protocol_name}=${EMPTY}    ${classification}=${EMPTY}    ${rich_description}=${EMPTY}    ${elements_per_page}=${EMPTY}    ${passing_score}=${EMPTY}    ${right_to_left}=${EMPTY}    ${version}=${EMPTY}    ${show_exam_summary}=${EMPTY}    ${external_sharing}=${EMPTY}    ${account}=${EMPTY}    ${supplier}=${EMPTY}

    #                           # Mandatory fields and arguments first
    #                           Enter Protocol Name         ${protocol_name}
    #                           Select Business Unit        ${business_unit}
    #                           Select Protocol Execution Style                         ${protocol_execution_style}

    #                           # Now the optional fields, default value is ${EMPTY}, let's skip these when not provided
    #                           IF                          '${additional_protocol_name}'!='${EMPTY}'
    #                           Enter Additional Protocol Name                          ${additional_protocol_name}
    #                           END

    #                           IF                          '${classification}'!='${EMPTY}'
    #                           Select Classification       ${classification}
    #                           END

    #                           IF                          '${rich_description}'!='${EMPTY}'
    #                           Enter Rich Description      ${rich_description}
    #                           END

    #                           IF                          '${elements_per_page}'!='${EMPTY}'
    #                           Enter Elements Per Page     ${elements_per_page}
    #                           END

    #                           IF                          '${passing_score}'!='${EMPTY}'
    #                           Enter Passing Score         ${${passing_score}}
    #                           END

    #                           IF                          '${right_to_left}'!='${EMPTY}'
    #                           Select Right to Left        ${right_to_left}
    #                           END

    #                           IF                          '${version}'!='${EMPTY}'
    #                           Enter Version               ${version}
    #                           END

    #                           IF                          '${show_exam_summary}'!='${EMPTY}'
    #                           Select Show Exam Summary    ${show_exam_summary}
    #                           END

    #                           IF                          '${external_sharing}'!='${EMPTY}'
    #                           Select External Sharing     ${external_sharing}
    #                           END

    #                           IF                          '${account}'!='${EMPTY}'
    #                           Search Account              ${account}
    #                           END

    #                           IF                          '${supplier}'!='${EMPTY}'
    #                           Search Supplier             ${supplier}
    #                           END