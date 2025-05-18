*** Settings ***
Library    QWeb
Resource                        ../resources/common.robot
Library                         QVision
Library                         DateTime
Suite Setup                     Setup Browser
Suite Teardown                  End suite




*** Test Cases ***



Login
    Login

Crate MD type Controlled
    Create New Worksheet
    UploadFile                  Upload Files                ../Files_To_Upload/Test Doc.docx      delay=5s             
    ClickText                   Done                        delay=2s
    promote Controlled record to effective
    
    ClickItem    Content Publication
    ClickText    close
    ClickElement                (//span[@class\='lcvb-icons'])                            timeout=10
    ClickText    Close
