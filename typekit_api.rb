require 'rubygems'
require 'curb'
require 'json'

# we need to have curb gem installed before running the program - please install it by doing sudo gem install curb
# From https://rubygems.org/gems/curb: Curb (probably CUrl-RuBy or something) provides Ruby-language bindings for the libcurl(3), a fully-featured client-side URL transfer library. cURL and libcurl live at http://curl.haxx.se/
class TypekitApi

  # Initialize a new TypekitApi object - constructor
  # options - :token - A String user token to use for authenticated requests.
  def initialize(options)
    @token = options[:token]
  end

   # Make a request to the Typekit API.
  def get_kits
    data = request('GET', "/kits")
    return data["kits"]
  end  

  # verb     - the String HTTP method to use (GET)
  # endpoint - the String API endpoint to request.
  # request('GET','/kits')  
  def request(verb, endpoint)

    #hit the Typekit API
    curl = Curl::Easy.new("https://typekit.com/api/v1/json#{endpoint}")
    curl.headers["X-Typekit-Token"] = @token

    # pass the HTTP verb - in our case it will be GET only
    curl.http(verb)

    # Raises RuntimeError if the Typekit API returns an error.
    data = JSON.parse(curl.body_str) or raise "Could not parse response #{curl.body_str}"

    # unless request was fullfilled(200) or found(302), display an error.
    unless [200, 302].include? curl.response_code
      # if the request is not valid, such as user inputs an invalid token it will raise not authorized (RuntimeError)
      raise data['errors'].first
    end

    data
  end

end
