*** Settings ***
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
    UPLOAD_FILE_MASTER_DOCUMENT
    promote Controlled record to effective