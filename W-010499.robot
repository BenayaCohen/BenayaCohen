*** Settings ***
Resource                        ./resources/common.robot
Library                         QVision
Library                         DateTime
Suite Setup                     Setup Browser
Suite Teardown                  End suite




*** Test Cases ***



Login
    Login

Crate MD type Controlled 
    Login
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    Create Controlled name
    PickList                    *Document Type              Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       qa
    save the record             
    Sleep                       5
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
    ClickText                   Done                        delay=2s
    Wait Until Keyword Succeeds                             60                          5                      ClickText               Actions    delay=5s
    ClickText                   Actions                     delay=2s
    ClickText                   Send for Review
    VerifyText                  Select Signatories for Revision Review
    ClickItem                   checkbox                    anchor=Admin validationxpress52     partial_match=False
    ClickText                   Next                        partial_match=False         delay=3s
    ClickItem                   checkbox                    anchor=Admin validationxpress52     partial_match=False    delay=3s
    ClickText                   Next                        partial_match=False
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin
    ClickText                   Next
    VerifyText                  E-Signature for Send for Review
    Sign with admin
    ClickText                   Actions                     partial_match=False         delay=6s
    HoverText                   Pending Review              delay=2s
    ClickText                   Sign
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin
    ClickText                   Actions                     partial_match=False         delay=6s
    ClickText                   Send For Approval
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin
    ClickText                   Actions                     partial_match=False         delay=6s
    ClickText                   Start Approval
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin
    ClickText                   Actions                     partial_match=False         delay=6s
    ClickText                   QA Approval - Skip Training                             partial_match=False    delay=6s
    TypeText                    Comments                    test
    ClickText                   Next
    VerifyText                  E-Signature for QA Approval
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin
    ClickText                   Generate PDF                delay=2s
    ${RN}=                      GetFieldValue               Revision Number
    WHILE                       ${RN}
        ClickFieldValue         Master Document
        IF                      ${RN} == 10.0
            LogScreenshot
        ELSE
            Log                 Revision Number is les then 10.0
        END
        ${RN}=                  GetFieldValue               Revision Number
        Should Not Be Equal     ${RN}                       10.0
        Wait Until Keyword Succeeds                         60                          5                      ClickText               New    delay=5s
        ClickText               Confirm
        Wait Until Keyword Succeeds                         60                          5                      ClickText               Actions    delay=5s
        ClickText               Actions                     delay=2s
        ClickText               Send for Review
        VerifyText              Select Signatories for Revision Review
        ClickItem               checkbox                    anchor=Admin validationxpress52     partial_match=False
        ClickText               Next                        partial_match=False         delay=3s
        ClickItem               checkbox                    anchor=Admin validationxpress52     partial_match=False    delay=3s
        ClickText               Next                        partial_match=False
        TypeText                Description of Change       test                        delay=3s
        TypeText                Rationale of Revision       test
        ComboBox                Search People...            Admin
        ClickText               Next
        VerifyText              E-Signature for Send for Review
        Sign with admin
        ClickText               Actions                     partial_match=False         delay=6s
        HoverText               Pending Review              delay=2s
        ClickText               Sign
        Wait Until Keyword Succeeds                         60                          5                      Sign with admin
        ClickText               Actions                     partial_match=False         delay=6s
        ClickText               Send For Approval
        Wait Until Keyword Succeeds                         60                          5                      Sign with admin
        ClickText               Actions                     partial_match=False         delay=6s
        ClickText               Start Approval
        Wait Until Keyword Succeeds                         60                          5                      Sign with admin
        ClickText               Actions                     partial_match=False         delay=6s
        ClickText               QA Approval - Skip Training                             partial_match=False    delay=6s
        TypeText                Comments                    test
        ClickText               Next
        VerifyText              E-Signature for QA Approval
        Wait Until Keyword Succeeds                         60                          5                      Sign with admin
        ClickText               Generate PDF                delay=2s
    END
