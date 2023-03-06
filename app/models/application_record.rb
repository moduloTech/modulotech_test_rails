class ApplicationRecord < ActiveRecord::Base

  include Matchable

  primary_abstract_class

end
