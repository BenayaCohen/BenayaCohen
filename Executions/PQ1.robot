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
    ClickElement                (//span[@id\='window'])     timeout=10        delay=5s
step 16
    [Documentation]            Verify that the record page layout matches the layout in Appendix A 9.1.1.2
    #appendix 2
step 17
    [Documentation]            Verify that ‘Master Document Number’ field consist of 3 letters of ‘Document Type’ concatenated to the document number. * In case of ‘Document Type’= ‘Worksheet’, “WKS” letters will concatenate at the beginning. * In case of ‘Document Type’= ‘Protocol’, “PRT” letters will concatenate at the beginning
    Worksheet
    Protocol