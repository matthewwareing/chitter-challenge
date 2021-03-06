require './lib/user.rb'
describe User do
    describe '.create' do
        it 'creates a new user' do
            user = User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )
            expect(user.id).not_to be_nil
        end

        it 'hashes the password using BCrypt' do
            expect(BCrypt::Password).to receive(:create).with('test')
            User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )
        end
    end

    describe '.all' do
        it 'returns all users' do
            user = User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )

            expect(User.all.map(&:id)).to include user.id
        end
    end

    describe '.find' do
        it 'finds a user by id' do
            user = User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )
            expect(User.find(user.id).email).to eq user.email
        end

        it 'returns nil if there is no ID given' do
            expect(User.find(nil)).to eq nil
        end
    end

    describe '.authenticate' do
        it 'returns a user when given correct email + password' do
            user = User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )
            authenticated_user = User.authenticate('contact@matthewwareing.com', 'test')
            expect(authenticated_user.id).to eq user.id
        end

        it 'returns nil when given wrong email address' do
            user = User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )
            expect(User.authenticate('wrong@email.com', 'test')).to be_nil
        end

        it 'returns nil when given wrong password' do
            user = User.create(
                display_name: 'Matt',
                username: 'mdwareing',
                email: 'contact@matthewwareing.com',
                password: 'test'
            )
            expect(User.authenticate('contact@matthewwareing.com', 'wrong')).to be_nil
        end
    end
end