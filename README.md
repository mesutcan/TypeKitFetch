TypeKitFetch
============

A command line interface in Ruby to fetch information about your kits using the public Typekit API.

We need to have curb gem installed before running the program - please install it by doing sudo gem install curb

From https://rubygems.org/gems/curb: Curb (probably CUrl-RuBy or something) provides Ruby-language bindings for the libcurl(3), a fully-featured client-side URL transfer library. cURL and libcurl live at http://curl.haxx.se/


This program assumes you already have an authorized API token generated at https://typekit.com/account/tokens
You will also need to create and have at least 1 kit before running this API.
If you don't have any kits created, the program will display you do not have any kits

To create kit using the command line please refer to the POST method at https://typekit.com/docs/api/v1/:format/kits


CommandLineInterface class is a command line interface to fetch user generated type kits
TypekitApi class is used make requests and fetch the information about authorized kits using Typekit API.
Please refer to the detailed inline comments to understand how they work.

To run the program, all you need to do have is your token.

Ex:
ruby command_line_interface.rb --token=e79507d8bb6243f2b991fc67ea53a2bdbf96f183 

This will return: 

user has 1 kits
kit 1 is {"id"=>"ibp7hwm", "link"=>"/api/v1/json/kits/ibp7hwm"}
kit 1 id is: ibp7hwm
kit 1 link is: /api/v1/json/kits/ibp7hwm