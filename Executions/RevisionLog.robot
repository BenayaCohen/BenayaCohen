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

Crate MD type Controlled 
    [Documentation]             Crate MD and promote to effective
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    Create Controlled name
    PickList                    *Document Type              Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       QA
    save the record
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx                   delay=3s
    ClickText                   Done
    Wait Until Keyword Succeeds                             60                          5                      ClickText               Actions
    ClickText                   Actions                     delay=2s
    ClickText                   Send for Review
    VerifyText                  Select Signatories for Revision Review
    ClickItem                   checkbox                    anchor=Admin Beta21         partial_match=False
    ClickText                   Next                        partial_match=False         delay=3s
    ClickItem                   checkbox                    anchor=Admin Beta21         partial_match=False    delay=3s
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
    ClickText                   History                     delay=2s
    ScrollTo                    Document Revision Logs
    VerifyText                  Revision Logs
    VerifyText                  Controlled BC               anchor=Document Revision Logs
    ClickFieldValue             Master Document
    Wait Until Keyword Succeeds                             60                          5                      ClickText               New    delay=5s
    ClickText                   Confirm
    Wait Until Keyword Succeeds                             60                          5                      ClickText               History    delay=5s
    ScrollTo                    Document Revision Logs
    VerifyText                  Revision Logs
    VerifyText                  Controlled BC               anchor=Document Revision Logs Name



Crate MD type Simple 
    [Documentation]             Crate MD and promote to effective
    LaunchApp                   Master Documents
    Click New Master Document type Simple
    Create simple name
    PickList                    *Document Type              Addendum
    PickList                    *Business Unit              General
    ComboBox                    Search Departments...       QA
    save the record
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
    ClickText                   Done                        delay=5s
    Wait Until Keyword Succeeds                             60                          5                      ClickText               Actions    delay=5s
    ClickText                   Actions                     delay=2s
    ClickText                   Approve
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin
    ClickText                   Next
    Sign with admin
    ClickText                   History                     delay=2s
    ScrollTo                    Document Revision Logs
    VerifyText                  Revision Logs
    VerifyText                  Simple BC                   anchor=Document Revision Logs Name
    ClickFieldValue             Master Document
    Wait Until Keyword Succeeds                             60                          5                      ClickText               New    delay=5s
    ClickText                   Confirm
    Wait Until Keyword Succeeds                             60                          5                      ClickText               History    delay=5s
    ScrollTo                    Document Revision Logs
    VerifyText                  Revision Logs
    VerifyText                  Simple BC                   anchor=Document Revision Logs Name


Crate MD type PromoMats 
    [Documentation]             Crate MD and promote to effective
    LaunchApp                   Master Documents
    Click New Master Document type Promotional Materials
    Create Promotional Materials name
    PickList                    *Document Type              Policy
    PickList                    *Business Unit              General
    PickList                    *Is this a Form or Translation?                         No
    ComboBox                    Search Departments...       QA
    save the record
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx                   delay=3s
    ClickText                   Done
    Wait Until Keyword Succeeds                             60                          5                      ClickText               Actions    delay=5s
    ClickText                   Actions                     delay=2s
    ClickText                   Send for Review
    VerifyText                  Select Signatories for Revision Review
    ClickItem                   checkbox                    anchor=Admin Beta21         partial_match=False
    ClickText                   Next                        partial_match=False         delay=3s
    ClickItem                   checkbox                    anchor=Admin Beta21         partial_match=False    delay=3s
    ClickText                   Next                        partial_match=False
    TypeText                    Description of Change       test                        delay=3s
    TypeText                    Rationale of Revision       test
    ComboBox                    Search People...            Admin
    ClickText                   Next
    VerifyText                  E-Signature for Send for Review
    Sign with admin
    VerifyText                  Authority Review Details                                delay=2s
    PickList                    Commercial Authority Status                             Approved
    TypeText                    Commercial Authority Comments                           test1
    PickList                    Legal Authority Status                                  Approved
    TypeText                    Legal Authority Comments                                test2
    PickList                    Medical Authority Status                                Approved
    TypeText                    Medical Authority Comments                              test3
    ClickText                   Actions                     partial_match=False         delay=6s
    ClickText                   Sign Promotional Material Review
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
    ClickText                   History                     delay=2s
    ScrollTo                    Document Revision Logs
    VerifyText                  Revision Logs
    VerifyText                  Controlled BC               anchor=Document Revision Logs
    ClickFieldValue             Master Document
    Wait Until Keyword Succeeds                             60                          5                      ClickText               New    delay=5s
    ClickText                   Confirm
    Wait Until Keyword Succeeds                             60                          5                      ClickText               History    delay=5s
    ScrollTo                    Document Revision Logs
    VerifyText                  Revision Logs
    VerifyText                  Controlled BC               anchor=Document Revision Logs Name
