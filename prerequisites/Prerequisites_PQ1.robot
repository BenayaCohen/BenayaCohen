*** Settings ***
Resource                        ../resources/common.robot
Library                         DataDriver                  file=edit_fields.csv
Suite Setup                     Setup Browser
Suite Teardown                  End suite



*** Test Cases ***
Prerequisites 1
    [Documentation]             One Master Documents records, Name = Temp2, type Controlled, Is Template = checked, Document Type = Policy, Document Sub Type = Validation Policy, in ‘Effective’ state exists in the system.
    Login
    LaunchApp                   Master Documents