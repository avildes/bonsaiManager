#The environment variable DATABASE_URL should be in the following format:
# => postgres://{user}:{password}@{host}:{port}/path. 5432
configure :production, :development do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/development')

	ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host     => db.host,
			:username => ENV['PG_USER'],
			:password => ENV['PG_PASS'],
			:database => db.path[1..-1],
			:encoding => 'utf8'
	)
end