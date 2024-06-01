User.find_or_create_by!(email: 'uno@test.test') { |u| u.password = '123456' }
User.find_or_create_by!(email: 'duo@test.test') { |u| u.password = '123456' }
User.find_or_create_by!(email: 'trio@test.test') { |u| u.password = '123456' }

# TODO: Add a room owned by uno
# TODO: Add a room owned by duo
