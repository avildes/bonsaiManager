require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require 'json'
require './models/sensor'
require './models/model'
require 'chartkick'
require 'openssl'
require 'base64'

configure do
  root = File.expand_path(File.dirname(__FILE__))
  set :views, File.join(root, 'app', 'views')
end

get '/' do
  @sensors = Sensor.getChartData()
  erb :index
end

not_found do
  status 404
  "Not found"
  #erb :not_found
end

def no_data
	status 204
	"No data to show"
end

def canPost key
	models = Model.where("id = ?", 1)
	return models[0].passValue == key
end

post '/post' do
	data = JSON.parse(request.body.read)
	auth = canPost(data["key"])
	if(auth)
		if(data != nil && data["sensors"].count > 0)
			data["sensors"].each do |element|
	  			@sensor = Sensor.new(element)
	  			@sensor.dateMeasured = Time.now
	  			if @sensor.save
	  				logger.info "Element saved"
	  			end
	  		end
	  	end
  	end
end