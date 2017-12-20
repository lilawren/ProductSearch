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

require 'test_helper'

class QueryCacheTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
