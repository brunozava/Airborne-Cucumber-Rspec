Given("the user informed the following data") do |table|       
    @new_user = table.rows_hash                                               
end         

Given("informed email shoud no be registered") do
    delete '/api/users/' + @new_user[:email]
end

Given("this email is already registered") do
    post 'api/uses', @new_user
end
   
When("I perform a request from POST type to the users service") do
    post 'api/uses', @new_user   
end  

                                                                 
Then("HTTP response code should be {int}") do |status_code|            
    expect_status status_code                                              
end                                                            