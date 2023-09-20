# NOTE: readme.txt contains important information you need to take into account
# before running this suite.
   # example for xpath that need to select the child of the father div: 
   # ClickElement                (//div[@class\='slds-no-flex actionIcons']/child::lightning-icon)     timeout=10     index=3
   #  ClickElement                (//span[@id\='window'])     timeout=10

*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver                  file=edit_fields.csv
Suite Setup                     Setup Browser
Suite Teardown                  End suite



*** Test Cases ***
step 1
    [Documentation]             Log into Dot Compliance Suite, Navigate to Master Documents tab
    LaunchApp                   Master Documents

step 2
    [Documentation]             Create a new Master Documents record. On ‘Record Type’ select “Simple” value and click next. Verify that the following fields are required for saving the record: Document Name Document Type Department Business Unit
    Click New Master Document type Simple
    verify the fields are required

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
    ClickText                   Next
    VerifyText                  The following fields are mandatory in order to promote the record state. Please populate the fields and save in order to continue.
step 7    
    [Documentation]             Fill in the required field and click Next
    TypeText                    Comments                    test
    ClickText                   Next
step 8
    [Documentation]             Fill in the user Alias and password and click "Sign"
    Sign with admin

steps 9
    [Documentation]             Click 'Edit' and verify that the following fields are editable: Document Name (Text) Master Document Number (Text) Document Type (Picklist) Document Legacy Number (Text) Override Master Document Number (Checkbox) Department (Lookup: Department) Business Unit (Picklist) Classification (Picklist) Keywords (Text) Is it a Form or Translation? (Picklist) Master Document (Lookup: Master Document) Language (Picklist) Additional Document Name (Text) Effective Date (Date) Revision Number (Text) Last Periodic Review (Date) Periodic Review Required (Checkbox) Review Period (Number) Account (Lookup: Account) Supplier (Lookup: Supplier) File URL (URL) PDF URL (URL) Finally click Cancel.

step 10
    [Documentation]             Click Edit. On Document Type choose value: ‘Policy’ Verify that “Document Subtype” field is editable
    ClickText                   Edit                        anchor=Sharing
    UseModal                    on
    PickList                    *Document Type              Policy
    VerifyPickList              Document Subtype
step 11
    [Documentation]             Click 'Edit' and populate 'Document Legacy Number' field. Click Save.
    TypeText                    Document Legacy Number      123
    ClickText                   Save                        partial_match=False
step 12
    [Documentation]             Click 'Edit' and populate the 'Override Master Document Number' checkbox with TRUE value. Click Save.
    ClickText                   Edit                        anchor=Sharing
    UseModal                    on
    ClickCheckbox               Override Master Document Number                     on
    ClickText                   Save                        partial_match=False
step 13
    [Documentation]             Verify that 'Master Document Number' field was automatically populated according to 'Document Legacy Number' field.
    GetFieldValue               Master Document Number