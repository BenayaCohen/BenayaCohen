# NOTE: readme.txt contains important information you need to take into account
# before running this suite.
   # example for xpath that need to select the child of the father div: 
   # ClickElement                (//div[@class\='slds-no-flex actionIcons']/child::lightning-icon)     timeout=10     index=3
   #  ClickElement                (//span[@id\='window'])     timeout=10

*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver                  file=edit_fields.csv
Library                         QVision
Suite Setup                     Setup Browser
Suite Teardown                  End suite



*** Test Cases ***
step 1
    [Documentation]             Log into Dot Compliance Suite, Navigate to Master Documents tab
    LaunchApp                   Master Documents

step 2
    [Documentation]             Create a new Master Documents record. On ‘Record Type’ select “Simple” value and click next. Verify that the following fields are required for saving the record: Document Name Document Type Department Business Unit
    Click New Master Document type Simple
    verify the fields are required for simple

step 3
    [Documentation]             Fill in the required fields and click Save. *For Business unit set ‘General’ value
    Appendix
steps 4
    [Documentation]             Verify that the record page layout matches the layout in Appendix A 9.1.1.1
    #apendix


step 5
    [Documentation]             From the Life cycle path verify that the following action is available: Cancel
    ClickText                   Actions                     partial_match=False
    UseModal                    on
    VerifyText                  Cancel                      anchor=Opened
steps 6
    [Documentation]             From the Life Cycle Path perform the following action: Cancel Verify that the following field is required for saving the record: Comments
    ClickText                   Cancel
    required field for Cancel and Re-Open
step 7    
    [Documentation]             Fill in the required field and click Next
    TypeText                    Comments                    test
    ClickText                   Next

step 8
    [Documentation]             Fill in the user Alias and password and click "Sign"
    Sign with admin

steps 9
    [Documentation]             Verify that all the fields are locked for editing except for the following fields: Owner, Effective Date, File URL. Keywords, PDF URL, Revision Number
    ClickText                   Edit                        anchor=Sharing
    #need to complete the step
step 10
    [Documentation]             From the Life Cycle Path verify that the following action is available: Re-Open
    ClickText                   Actions
    VerifyText                  Re-Open                     anchor=Canceled
step 11
    [Documentation]             From the Life Cycle Path perform the following action: Re-Open Verify that the following field is required for saving the record: Comments
    ClickText                   Re-Open
    required field for Cancel and Re-Open

step 12
    [Documentation]             Fill in the required field and click Save
    TypeText                    Comments                    test
    ClickText                   Save
step 13
    [Documentation]             Locate a file to upload. From ‘File Preview’ tab click or Drag a file to the Initial File Upload outlined section.
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx
step 14
    [Documentation]             Click on ‘Done’ button.
    ClickText                   Done
step 15
    [Documentation]             Navigate back to ‘Master Document’ record. Use the link from compact layout
    ClickElement                (//span[@id\='window'])     timeout=10                  delay=5s
step 16
    [Documentation]             Verify that the record page layout matches the layout in Appendix A 9.1.1.2
    #appendix 2
step 17
    [Documentation]             Verify that ‘Master Document Number’ field consist of 3 letters of ‘Document Type’ concatenated to the document number. * In case of ‘Document Type’= ‘Worksheet’, “WKS” letters will concatenate at the beginning. * In case of ‘Document Type’= ‘Protocol’, “PRT” letters will concatenate at the beginning
    Worksheet
    Protocol
step 18
    [Documentation]             Click 'Edit' and verify that the following fields are editable: Document Name (Text) Master Document Number (Text) Document Type (Picklist) Document Sub type (Picklist) Document Legacy Number (Text) Override Master Document Number (Checkbox) Department (Lookup: Department) Business Unit (Picklist) Classification (Picklist) Keywords (Text) Is it a Form or Translation? (Picklist) Master Document (Lookup: Master Document) Language (Picklist) Template Document (Lookup) Additional Document Name (Text) Effective Date (GMT) (Date) Revision Number (Text) Last Periodic Review (Date) Periodic Review Required (Checkbox) Review Period (Number) Account (Lookup: Account) Supplier (Lookup: Supplier) File URL (URL) PDF URL (URL) Finally click Cancel.
    #need to complete the step
step 19      
    [Documentation]             Click Edit. On Document Type choose value: ‘Policy’ Verify that “Document Subtype” field is editable
    ClickText                   Edit                        anchor=Sharing
    PickList                    *Document Type              Policy                      delay=1s
    VerifyPickList              Document Subtype
step 20
    [Documentation]             Click 'Edit' and populate 'Document Legacy Number' field.
    TypeText                    Document Legacy Number      1236
    save the record
step 21
    [Documentation]             Click 'Edit' and populate the 'Override Master Document Number' checkbox with TRUE value.
    ClickText                   Edit                        anchor=Sharing
    UseModal                    on
    ClickCheckbox               Override Master Document Number                         on
    save the record
step 22
    [Documentation]             Verify that 'Master Document Number' field was automatically populated according to 'Document Legacy Number' field.
    GetFieldValue               Master Document Number
step 23
    [Documentation]             Click ‘Edit’, delete the value 'Document Legacy Number' field and click Save
    ClickText                   Edit                        anchor=Sharing
    TypeText                    Document Legacy Number      ${EMPTY}
    save the record
    VerifyText                  Legacy Document

step 24
    [Documentation]             Delete the values from both 'Override Master Document Number' and 'Document Legacy Number' fields and click Save
    UseModal                    on
    ClickCheckbox               Override Master Document Number                         off
    save the record
step 25
    [Documentation]             Navigate to the Document Revision record. Promote the record to the following state: Effective (Simple)
    #need to verify the script
    promote simpel record to effective
step 26
    [Documentation]             Navigate back to the Master Document Record Verify that the Master Document is in the following state:
    ClickElement                (//div[@class\='slds-grid'])                            anchor=Master Document
    VerifyText                  Effective (Simple)          anchor=Actions              delay=5s
step 27
    [Documentation]             Verify that all the fields are locked for editing except for the following fields: Owner, Effective Date, File URL. Keywords, PDF URL, Revision Number, Last Periodic Review, Next Periodic Review, Review Period, Supplier
    #need to complete the step
step 28
    [Documentation]             Navigate to Master Documents Tab. Create a new Master Documents record. On ‘Record Type’ select “Controlled” value and click Next. ‘Document Name’: Temp1 'Periodic Review Required' checked ‘Review Period field is populated with "36" value. Verify that the following fields are required for saving the record: Document Name Document Type Department Business Unit Is this a form or a translation?
    LaunchApp                   Master Documents
    Click New Master Document type Controlled
    typeText                    *Document Name              test
    ScrollTo                    Document Dates
    verifyCheckbox              Periodic Review Required    on    
    VerifyText                  36                                              
    save the record
    verify the fields are required for Controlled

step 29 
    [Documentation]