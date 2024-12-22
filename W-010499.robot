*** Settings ***
Resource                        ./resources/common.robot
Library                         QVision
Library                         DateTime
Suite Setup                     Setup Browser
Suite Teardown                  End suite




*** Test Cases ***



Login
    Login
    LogScreenshot