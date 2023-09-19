*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver                  file=edit_fields.csv
Suite Setup                     Setup Browser
Suite Teardown                  End suite



*** Test Cases ***

login
    Login
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
    ClickText                   Save                        partial_match=False
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
    ClickText                   Done

    ClickText                   Actions                     partial_match=False
    ClickText                   Send for Review
    ClickItem                   checkbox                    anchor=Admin User    partial_match=False
    ClickText                   Next                        partial_match=False
    ClickItem                   checkbox                    anchor=Admin User    partial_match=False
    ClickText                   Next                        partial_match=False
    TypeText                    Description of Change       test
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin User
    ClickText                   Next
    Wait Until Keyword Succeeds                        60                        5    Sign with admin
    

    ClickText                   Actions                     partial_match=False
    ClickText                   Start Review 
    Wait Until Keyword Succeeds                        60                        5    Sign with admin


    ClickText                   Actions
    ClickText                   Send For Approval
    Sign with admin

    ClickText                   Actions
    ClickText                   Sign Document Approval
    Sign with admin

    ClickText                   Actions
    ClickText                   QA Approval
    PickList                    Applicable Training Plan Attached?                      No
    ClickText                   Next
    Sign with admin

                                              