*** Settings ***
Documentation       Robot Framework test suite for ReqRes API (Create, Get, Update, Delete)

Library             RequestsLibrary
Library             Collections
Resource            ../../config/reqres_config.robot

# Create a session named "reqres" using the BASE_URL from our config
Suite Setup         Create Session    reqres    ${BASE_URL}


*** Test Cases ***
Create User
    [Documentation]    Test creating a new user with POST /users
    ${request_body}=    Create Dictionary    name=${CREATE_USER_NAME}    job=${CREATE_USER_JOB}
    ${response}=    Post On Session    reqres    /users    json=${request_body}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    201
    # Check response structure
    Dictionary Should Contain Key    ${response.json()}    id
    Dictionary Should Contain Key    ${response.json()}    createdAt
    # Check fields
    Should Be Equal    ${response.json()['name']}    ${CREATE_USER_NAME}
    Should Be Equal    ${response.json()['job']}    ${CREATE_USER_JOB}

Get Single User
    [Documentation]    Test retrieving an existing user with GET /users/${USER_ID}
    ${response}=    GET On Session    reqres    /users/${USER_ID}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    200
    # Check response has the 'data' field
    Dictionary Should Contain Key    ${response.json()}    data
    # Convert the user ID to an integer
    ${user_id}=    Convert To Integer    ${USER_ID}
    # Verify the user ID is correct in the response
    Should Be Equal    ${response.json()['data']['id']}    ${user_id}

Update User
    [Documentation]    Test updating an existing user with PUT /users/${USER_ID}
    ${request_body}=    Create Dictionary    name=${UPDATE_USER_NAME}    job=${UPDATE_USER_JOB}
    ${response}=    Put On Session    reqres    /users/${USER_ID}    json=${request_body}
    # Check response code
    Should Be Equal As Integers    ${response.status_code}    200
    # Check response structure
    Dictionary Should Contain Key    ${response.json()}    updatedAt
    # Check updated fields
    Should Be Equal    ${response.json()['name']}    ${UPDATE_USER_NAME}
    Should Be Equal    ${response.json()['job']}    ${UPDATE_USER_JOB}

Delete User
    [Documentation]    Test deleting an existing user with DELETE /users/${USER_ID}
    ${response}=    Delete On Session    reqres    /users/${USER_ID}
    # For successful delete, ReqRes returns 204 No Content
    Should Be Equal As Integers    ${response.status_code}    204
