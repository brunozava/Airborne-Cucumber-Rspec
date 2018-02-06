Feature: Products registrations
    Being a client application which register Products
    that I can request a POST requisition
    To register the products that the user wants to display in eStore

    @post_p @token
    Scenario: New product
        Given User informed the follow product data registrations
            | name        | Pokemon Shirt           |
            | description | Bulbasaur shirt         |
            | price       | 69.99                   |
            | quantity    | 10                      |
            | available   | true                    |
            | tags        | shirt, cartoon, network |
        And this product has the following tags
            | tags    |
            | pokemon |
            | shirt   |
            | cartoon |
        And This product should not be registered
        When I perform a request from POST type to the products service
        Then HTTP response code should be 200

    @dup_p @token
    Scenario: Duplicated Product
        Given User informed the follow product data registrations
            |name|Dragon ball Shirt|
            |description| Goku shirt|
            |price|70.99|
            |quantity|10|
            |available|true|
            |tags|shirt, anime, artoon|
        And this product has the following tags
            |tags|
            |dragon ball|
            |shirt|
            |anime|
        But this product is already registered
        When I perform a request from POST type to the products service
        Then HTTP response code should be 409
        And I should see the HTTP message 'Product can't be duplicated.'



