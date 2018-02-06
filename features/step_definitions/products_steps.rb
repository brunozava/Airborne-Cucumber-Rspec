#POST
Given("User informed the follow product data registrations") do |table|
    prd = table.rows_hash
    @new_product = {
        name: prd["name"],
        description: prd["description"],
        price: prd["price"].to_f,
        quantity: prd["quantity"].to_i,
        available: prd["available"],
        tags: []
    }
end
  
Given("this product has the following tags") do |tags|
    tags.hashes.each do |t|
        @new_product[:tags].push(t[:tags])
    end
    #tags.hashes.each { |t| @new_product[:tags].push(t[:tags]) }
end

Given("This product should not be registered") do
    get 'api/products?name=' + @new_product[:name]

    #if json_body.size > 0
    unless json_body.empty?
        product_id = json_body.first[:id]
        delete 'api/products/' + product_id, {}, { 'ACCESS_TOKEN' => @token }
    end
    
end

Given("this product is already registered") do                                              
    steps %{
        And This product should not be registered
        When I perform a request from POST type to the products service
    }               
end 
  
When("I perform a request from POST type to the products service") do
    # post 'endpoint/api/service', @body, @headers
    post 'api/products', @new_product, { 'ACCESS_TOKEN' => @token }
end

                                                                                                                                                                                   
Then("I should see the HTTP message {string}") do |message|                                  
    #expect(json_body[:message]).to eql message
    expect_json(message:message)
end     

#GET

When("I perform a request from GET type to the products service") do                
    get '/api/products/'
end                                                                                 
                                                                                        
Then("I should see a product list") do                                              
    expect_json_types(:array)
    expect_json_types('*',
                        name: :string,
                        description: :string,
                        price: :float,
                        quantity: :integer,
                        available: :boolen,
                        tags: :array)
end  


#GET/:ID

Given("The user selected a product in eStore") do                                 
    steps %{    
        When I perform a request from GET type to the products service
    }
    @unique_product = json_body.sample
end                                                                               

Given("user selected an unavailable product") do
    @unique_product = { id: Faker::Lorem.characters(25) }
end

When("I perform a request from GET type to a single product") do                  
     get "/api/products/#{@unique_product[:id]}"    
end                                                                               
                                                                                    
Then("This product data should be displayed in the request body") do              
    expect(json_body).to eql @unique_product    
end                                                                               