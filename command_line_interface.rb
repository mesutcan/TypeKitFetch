# load the typekitapi file who has the TypekitApi class
load 'typekit_api.rb'
require 'rubygems'
require 'optparse'

# A command line interface to fetch user generated type kits
# This assumes user already has at least 1 typekit created.
# I already created a typekit using a POST request.
# the token I am using is e79507d8bb6243f2b991fc67ea53a2bdbf96f183
class CommandLineInterface

  # argv - An Array of command line arguments.
  # Raises ArgumentError if no token is provided.
  def run(argv)

   #get the filename  
    prog = File.basename($0)

    # parse the options.
    # in this case the only needed option is token since we are making a GET request.
    options = {
      :token   => ''
    }

    argv.options do |opts|
      opts.banner = "Usage: ruby #{prog} --token=token"

      opts.separator ""
      opts.separator "Required options:"

      # show the options
      opts.on('-t', '--token=token', 'Authentication token to use') { |token| options[:token] = token }
      opts.on_tail('-h', '--help', 'Show this message')             { puts opts; exit 0; }
      opts.parse!
    end or exit 1

    # Make sure we have the token input from the user
    abort "#{prog}: missing argument: --token" if options[:token].empty?

    #create a new TypekitApi object and pass the user entered token from the command line
    typekit = TypekitApi.new(:token => options[:token])

    # make a get request to fetch the kits user has    
    kit_ids = typekit.get_kits
    
    # display the number of kits a user has
    # display the kit number, kit id and kit link 
    unless kit_ids.empty?
      puts "user has #{kit_ids.length} kits"
      kit_ids.each_with_index do |ki,index|
        puts "kit #{index+1} is #{ki}"
        puts "kit #{index+1} id is: #{ki['id']}"
        puts "kit #{index+1} link is: #{ki['link']}"
      end  
    else
      # if user has no kits, display you do not have any kits
      puts "you do not have any kits"
    end      
  end

end

# run the program with the arguments entered from the command line
CommandLineInterface.new.run(ARGV)
exit 0

