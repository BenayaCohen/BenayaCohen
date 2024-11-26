*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver                  file=edit_fields.csv
Library                         QVision
Library                         DateTime
Suite Setup                     Setup Browser
Suite Teardown                  End suite



*** Test Cases ***



Login
    Login

Prerequisites 1
    [Documentation]             One Master Documents records, Name = Temp2, type Controlled, Is Template = checked, Document Type = Policy, Document Sub Type = Validation Policy, in ‘Effective’ state exists in the system.
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    Create Controlled name
    PickList                    *Document Type              Policy
    PickList                    Document Subtype            Validation Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ClickCheckbox               Is Template                 on
    ComboBox                    Search Departments...       QA
    save the record
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
    ClickText                   Done
    Wait Until Keyword Succeeds                             60                          5                      ClickText               Actions    delay=5s
    ClickText                   Send for Review
    VerifyText                  Select Signatories for Revision Review
    ClickItem                   checkbox                    anchor=Admin            partial_match=False
    ClickText                   Next                        partial_match=False         delay=3s
    ClickItem                   checkbox                    anchor=Admin            partial_match=False    delay=3s
    ClickText                   Next                        partial_match=False
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin User
    ClickText                   Next
    VerifyText                  E-Signature for Send for Review
    Sign with admin
    ClickText                   Actions                     partial_match=False         delay=12s
    HoverText                   Pending Review              delay=2s
    ClickText           Sign
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

