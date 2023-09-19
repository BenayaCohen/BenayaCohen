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
    PickList                    Document Subtype           Validation Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                     No
    ClickCheckbox               Is Template                 on
    ComboBox                    Search Departments...       test
    ClickText                   Save                        partial_match=False
    UploadFile                  Files_To_Upload/Test Doc.docx                       filename=Test Doc.docx 
    ClickText                   Done