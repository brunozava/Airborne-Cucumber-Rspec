#encoding: utf-8

Feature: New user registration
    As an application Web
    can request a POST requisition
    to perform an user registration

    Scenario: New user

        Given the user informed the following data
            | name  | Bruno Zavanella |
            | email | bruno@zava.com  |
            | password | 123456       |
        And informed email shoud no be registered
        When I perform a request from POST type to the users service
        Then HTTP response code should be 200

    Scenario: Email already registered
        Given the user informed the following data
            | name  | Bruno Zavanella |
            | email | bruno@zava.com  |
            | password | 123456       |
        And this email is already registered
        When I perform a request from POST type to the users service
        Then HTTP response code should be 400