*** Settings ***
Documentation       Robot Framework test suite for ReqRes API (Create, Get, Update, Delete, and additional tests)

Library             RequestsLibrary
Library             Collections
Library             String
Resource            ../../config/reqres_config.robot

# Create a session named "reqres" using the BASE_URL from our config
Suite Setup         Create Session    reqres    ${BASE_URL}
Suite Teardown      Delete All Sessions


*** Variables ***
# Common variables for validation
@{REQUIRED_FIELDS_CREATE}       name    job    id    createdAt
@{REQUIRED_FIELDS_UPDATE}       name    job    updatedAt
@{REQUIRED_FIELDS_GET}          id    email    first_name    last_name    avatar
@{REQUIRED_FIELDS_DELETE}       @{EMPTY}    # No content expected

*** Test Cases ***
Create User Successfully
    [Documentation]    Test creating a new user with POST /users and verify all fields
    ${request_body}=    Create Dictionary    name=${CREATE_USER_NAME}    job=${CREATE_USER_JOB}
    ${response}=    Post On Session    reqres    /users    json=${request_body}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    201
    # Check response structure
    FOR    ${field}    IN    @{REQUIRED_FIELDS_CREATE}
        Dictionary Should Contain Key    ${response.json()}    ${field}
    END
    # Check fields
    Should Be Equal    ${response.json()['name']}    ${CREATE_USER_NAME}
    Should Be Equal    ${response.json()['job']}    ${CREATE_USER_JOB}

Get Single User Successfully
    [Documentation]    Test retrieving an existing user with GET /users/${USER_ID} and verify all fields
    ${response}=    GET On Session    reqres    /users/${USER_ID}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    200
    # Check response has the 'data' field
    Dictionary Should Contain Key    ${response.json()}    data
    # Check data structure
    FOR    ${field}    IN    @{REQUIRED_FIELDS_GET}
        Dictionary Should Contain Key    ${response.json()['data']}    ${field}
    END
    # Verify the user ID is correct in the response
    ${USER_ID_INTEGERS}=    Convert To Integer    ${USER_ID}
    Should Be Equal    ${response.json()['data']['id']}    ${USER_ID_INTEGERS}
    # Validate email format
    # Should Match Regexp    ${response.json()['data']['email']}    ^[\w\.-]+@[\w\.-]+\.\w+$

Update User Successfully
    [Documentation]    Test updating an existing user with PUT /users/${USER_ID} and verify all fields
    ${request_body}=    Create Dictionary    name=${UPDATE_USER_NAME}    job=${UPDATE_USER_JOB}
    ${response}=    Put On Session    reqres    /users/${USER_ID}    json=${request_body}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    200
    # Check response structure
    FOR    ${field}    IN    @{REQUIRED_FIELDS_UPDATE}
        Dictionary Should Contain Key    ${response.json()}    ${field}
    END
    # Check updated fields
    Should Be Equal    ${response.json()['name']}    ${UPDATE_USER_NAME}
    Should Be Equal    ${response.json()['job']}    ${UPDATE_USER_JOB}

Delete User Successfully
    [Documentation]    Test deleting an existing user with DELETE /users/${USER_ID} and verify no content
    ${response}=    Delete On Session    reqres    /users/${USER_ID}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    204
    # Verify response body is empty
    Should Be Empty    ${response.content}

Update User with Invalid Job
    [Documentation]    Test updating a user with an invalid job title and verify handling
    ${invalid_job}=    Set Variable    ""
    ${request_body}=    Create Dictionary    name=${UPDATE_USER_NAME}    job=${invalid_job}
    ${response}=    Put On Session    reqres    /users/${USER_ID}    json=${request_body}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()['job']}    ${invalid_job}

Register User Successfully
    [Documentation]    Test registering a user with POST /register and verify response
    ${request_body}=    Create Dictionary    email=${VALID_USER_EMAIL}    password=${VALID_USER_PASSWORD}
    ${response}=    Post On Session    reqres    /register    json=${request_body}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    id
    Dictionary Should Contain Key    ${response.json()}    token

Login User Successfully
    [Documentation]    Test logging in a user with POST /login and verify response
    ${request_body}=    Create Dictionary    email=${VALID_USER_EMAIL}    password=${VALID_USER_PASSWORD}
    ${response}=    Post On Session    reqres    /login    json=${request_body}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token
