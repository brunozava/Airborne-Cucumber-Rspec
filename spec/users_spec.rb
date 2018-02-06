
describe('GET /users') do
    it('API OK') do
        get '/'
        expect_status 200
    end
end

describe('POST /users') do
    describe('status 200') do
        before do
            @new_user = { name: 'Bruno', email: 'bruno@zava.com', password: '123456' }
            delete '/api/users/' + @new_user[:email]
        end

        it('New user') do
            post '/api/users', @new_user
            expect_status 200
        end
    end

    describe('status 409') do
        before(:all) do
            @new_user = { name: 'Bruno2', email: 'bruno2@zava.com', password: '123456' }
            delete '/api/users/' + @new_user[:email]
            post '/api/users', @new_user
        end

        it('Email already registered') do
            post '/api/users', @new_user
            expect_status 409
            expect_json(
                message: 'Duplicated email!'
            )
        end

        it('Blank name') do
            post '/api/users', { name:'', email: 'bruno@zava.com', password: '123456' }
            expect_status 409
            expect_json(
                message: 'Name is required!'
            )
        end

        it('Blank email') do
            post '/api/users', { name:'Bruno', email: '', password: '123456' }
            expect_status 409
            expect_json(
                message: 'Email is required!'
            )
        end

        it('Blank password') do
            post '/api/users', { name:'Bruno', email: 'bruno@zava.com', password: '' }
            expect_status 409
            expect_json(
                message: 'Password is required!'
            )
        end


    end

after(:each) do |e|
    puts json_body if e.exception
end

end