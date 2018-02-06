Before('token') do
    post 'api/token', email: 'bruno@zava.com', password: '123456'
    expect_status 200
    @token = json_body[:accss_token]
end

After do |scenario|
    if scenario.failed?
        puts 'REQUEST:'
        puts @new_product
        puts 'JSON BODY RESPONSE'
        puts json_body
end