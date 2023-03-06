module Matchable

  extend ActiveSupport::Concern

  class_methods do
    def match_by(matching_pair)
      pair = matching_pair.to_a[0]
      where(arel_table[pair[0]].matches("%#{sanitize_sql_like(pair[1])}%"))
    end
  end

end
