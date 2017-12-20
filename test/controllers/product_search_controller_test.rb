class CacheTest < ActionDispatch::IntegrationTest
  test "Test cache in database for product queries" do
    query = 'cats'.downcase.strip

    cached = QueryCache.where(query: query).first
    assert_nil(cached, "Database should have cache miss")

    get '/product_search', params: {search: query, commit: 'Search'}
    assert_response :success

    cached = QueryCache.where(query: query).first
    assert_not_nil(cached, "Database should have cache hit")
  end
end