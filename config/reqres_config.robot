*** Settings ***
Documentation       Configuration file for testing the ReqRes API


*** Variables ***
${BASE_URL}             https://reqres.in/api
${USER_ID}              2

# Data used for create/update tests
${CREATE_USER_NAME}     John
${CREATE_USER_JOB}      Developer

${UPDATE_USER_NAME}     Jane
${UPDATE_USER_JOB}      Manager
