module HelperMethods
  def stub_success(address,fixture=nil,options={})
    result = case
    when fixture.present? then JSON.parse(fixture_response(fixture))
    when options[:result] then options[:result]
    else []
    end
    options[:method] ||= :get
    stub_request(options[:method].to_sym, address).
             to_return(:status => 200, :body => result, :headers => {})
  end

  def fixture_response(filename)
    IO.read("#{Rails.root}/spec/fixtures/#{filename}")
  end

  def stub_not_found(address,options={})
    options[:method] ||= :get
    stub_request(options[:method].to_sym, address).
             to_return(:status => 404, :body => 'ActiveRecord::RecordNotFound', :headers => {})
  end

  def stub_access_denied(address,options={})
    options[:method] ||= :get
    stub_request(options[:method].to_sym, address).
             to_return(:status => 401, :body => "HTTP Basic: Access denied.")
  end

  def stub_failure(address,options={})
    options[:method] ||= :get
    options[:code] ||= 404
    body = case options[:code]
    when 404 then 'ActiveRecord::RecordNotFound'
    when 401 then 'HTTP Basic: Access denied.'
    else ''
    end
    body = JSON.parse(fixture_response(options[:fixture])) if options[:fixture]
    stub_request(options[:method].to_sym, address).
             to_return(:status => options[:code], :body => body)
  end

  def stub_twitter_profile
    address=/api.twitter.com\/1.1\/users\/show.json\?screen_name=/
    result = JSON.parse(fixture_response('twitter_user.json'))
    response = stub_request(:get, address).
             to_return(:status => 200, :body => result, :headers => {})

    Twitter::User.new(result.symbolize_keys)
  end
end

def stub_geocoding
  result = fixture_response('google_map_response.xml')
  stub_request(:get, /maps.google.com/).to_return(:status => 200, :body => result, :headers => {})
end