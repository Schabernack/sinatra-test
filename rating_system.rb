# simple rating system. 
# Das rating wird in die db.json datei auf die festplatte persistiert.

require 'sinatra'
require 'rubygems'
require 'json'


# wurde noch kein rating angelegt setze die score auf 1, ansonsten lese rating aus der db.json datei aus.
# ergebnis wird als json zurückgesendet
get '/rating' do
	if(File.exists?('db.json')) 
		score = JSON(File.read('db.json'))["rating"]
	else 
		score = 1
	end

	content_type :json
	{ :rating => score}.to_json
end

# persistiere rating in db.json datei
post '/rating' do
	foo = {
		rating: params[:rating]
	}
	File.open("db.json","w") do |f|
  		f.write(foo.to_json)
	end
	#return 200 OK Code
	200
end

# liefere startseite bei aufruf der rating.html
get '/' do
	File.read('rating.html')
end