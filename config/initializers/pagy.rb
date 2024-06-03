# config/initializers/pagy.rb

# Set default items per page
Pagy::DEFAULT[:items] = 10

require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :last_page
