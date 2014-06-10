class Hash
  def &(other)
    reject { |k, v| !(other.include?(k) && other[k] == v) }
  end
end

class StatusCake
  include HTTParty

  base_uri 'https://www.statuscake.com/API'

  # We can only filter on these in the API.  Hopefully they will support more.
  SUPPORTED_QUERIES = ['CUID','Status']

  def initialize(opts)
    @auth = {'Username' => opts[:username], 'API' => opts[:api_key]}
  end

  def find(id)
    @opts = {headers:@auth, query:{ 'TestID' => id }}
    respond(self.class.get("/Tests/Details", @opts))
  end

  def tests(options={})
    # Hash#slice w/o activesupport
    query_opts  = options.select { |k,v| SUPPORTED_QUERIES.index(k) }
    filter_opts = options.reject { |k,v| SUPPORTED_QUERIES.index(k) }

    @opts = {headers:@auth, query:query_opts}
    tests = respond(self.class.get("/Tests", @opts))

    unless filter_opts.empty?
      tests.find_all { |t| (t & filter_opts) == filter_opts }
    else
      tests
    end
  end

  def update_test(test={})
    @opts = {headers:@auth, body:test }
    respond(self.class.put("/Tests/Update",@opts))
  end

  def delete_test(test={})
    @opts = {headers:@auth, body:{ 'TestID' => test['TestID'] } }
    respond(self.class.delete("/Tests/Details",@opts))
  end

  def pause_test(t)
    if t
      t['Paused'] = '1'
      update_test(t)
    end
  end

  def unpause_test(t)
    if t
      t['Paused'] = '0'
      update_test(t)
    end
  end

  protected

  def respond(response)
    if response.success?
      if response.is_a?(Hash) && response.has_key?('Error')
        raise response["Error"]
      else
        response
      end
    else
      raise response.response
    end
  end
end
