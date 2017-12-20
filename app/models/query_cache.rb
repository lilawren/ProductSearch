# == Schema Information
#
# Table name: query_caches
#
#  id         :integer          not null, primary key
#  query      :string
#  results    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QueryCache < ApplicationRecord
  serialize :results, Array
end
