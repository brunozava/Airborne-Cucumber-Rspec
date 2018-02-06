Feature: Product inquiry
    Being the catalog module from the eStore
    That I can request a GET requisition
    To dislay the products to the customers

    @get_p
    Scenario: List products
        When I perform a request from GET type to the products service
        Then HTTP response code should be 200
        And I should see a product list

    @get_up
    Scenario: List a single product
        Given The user selected a product in eStore
        When I perform a request from GET type to a single product
        Then HTTP response code should be 200
        And This product data should be displayed in the request body 

    @get_up_404
    Scenario: Product not found
        Given user selected an unavailable product
        When I perform a request from GET type to a single product
        Then HTTP response code should be 404
        And I should see the HTTP message 'Product not found.'
