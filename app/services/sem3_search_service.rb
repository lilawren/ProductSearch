class Sem3SearchService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def execute
    return [] unless params[:search]

    # check the cache first
    if cached = QueryCache.where(query: params[:search].downcase.strip).first
      cached.results
    # otherwise do the query
    else
      setup
      construct_query
      get_products
    end
  end

  private

  def setup
    @sem3 = Semantics3::Products.new(Rails.application.secrets.sem3_api_key,
                                     Rails.application.secrets.sem3_api_secret)
  end

  def construct_query
    @sem3.products_field('search', params[:search])
  end

  def get_products
    Rails.logger.info('+++ Sem3 API: Getting products... +++')

    r = @sem3.get_products()

    if r['code'].eql?('OK')
      # store result in cache
      results = r['results']
      QueryCache.create(query: params["search"].downcase.strip, results: results)
      results
    else
      if r['message']
        m = JSON.parse(r['message'])
        Rails.logger.debug("+++ Sem3 API Error: #{m['message']} Code: #{m['code']} +++")
      end

      []
    end
  end
end
