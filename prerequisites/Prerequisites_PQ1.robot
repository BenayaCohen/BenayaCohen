*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver                  file=edit_fields.csv
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         QVision



*** Test Cases ***


Prerequisites 1
    [Documentation]             One Master Documents records, Name = Temp2, type Controlled, Is Template = checked, Document Type = Policy, Document Sub Type = Validation Policy, in ‘Effective’ state exists in the system.
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    TypeText                    *Document Name              TempTest2
    PickList                    *Document Type              Policy
    PickList                    Document Subtype            Validation Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ClickCheckbox               Is Template                 on
    ComboBox                    Search Departments...       test
    save the record
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
    ClickText                   Done


    Wait Until Keyword Succeeds                             60                          5                      ClickText               Actions    delay=5s
    ClickText                   Send for Review
    VerifyText                  Select Signatories for Revision Review
    ClickItem                   checkbox                    anchor=Admin User           partial_match=False
    ClickText                   Next                        partial_match=False         delay=3s
    ClickItem                   checkbox                    anchor=Admin User           partial_match=False    delay=3s
    ClickText                   Next                        partial_match=False
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin User
    ClickText                   Next
    VerifyText                  E-Signature for Send for Review
    Sign with admin


    ClickText                   Actions                     partial_match=False         delay=12s
    QVision.ClickText           Sign
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin


    ClickText                   Actions                     partial_match=False         delay=12s
    ClickText                   Send For Approval
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin


    ClickText                   Actions                     partial_match=False         delay=12s
    ClickText                   Start Approval
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin

    ClickText                   Actions
    ClickText                   QA Approval - Skip Training                             partial_match=False    delay=12s
    TypeText                    Comments                    test
    ClickText                   Next
    VerifyText                  E-Signature for QA Approval
    Wait Until Keyword Succeeds                             60                          5                      Sign with admin


Prerequisites 2
    [Documentation]             One Master Document, Record type: “Simple”, Name: Form1, Document Type: “Form”, Business Unit: “General”, in “Opened” state, related to Document Revision record that the tested user is not its owner exist in the system.
    LaunchApp                   Master Documents
    Click New Master Document type Simple
    TypeText                    *Document Name              OQ1MD1 test7
    PickList                    *Document Type              Form
    PickList                    *Business Unit              General
    ComboBox                    Search Departments...       test
    save the record
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
    ClickText                   Done                        delay=5s
    ClickText                   Edit Revision Owner
    ComboBox                    Search People...            Standard User
    ClickText                   Save

Prerequisites 3
    [Documentation]             One protocol (Training Effectiveness) with at least one question and passing score, in state opened, exists in the system
    LaunchApp                   Protocols
    clickText                   New                         delay=3s
    ClickText                   Training Effectiveness      anchor=An electronic protocol designed as an exam, can be used as a verification for training effectiveness.
    ClickText                   Next
    TypeText                    *Protocol Name              ProTest2
    TypeText                    *Execution Limit            1
    TypeText                    *Passing Score              70
    save the record
    ClickText                   New                         delay=3s
    PickList                    *Question Type              Single Picklist
    TypeText                    *Short Description          test?
    TypeText                    *Choices                    Yes\nNo
    ClickText                   Save
    ClickElement                (//lightning-icon[@title\="Score Builder"])
    UseModal                    on
    TypeText                    (//input[@name\="ScoreInput"])                          100
    ClickElement                (//label[@class\="slds-checkbox__label"])               index=1
    ClickText                   Save
    UseModal                    off








