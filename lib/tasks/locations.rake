namespace :locations do
  desc "Write data from locations to a YML file"
  task :write => [:environment] do
    results = []
    Happening.approved.upcoming.each do |happening|
      a        = happening.location.lat_long.split(",")
      lat,lng  = a[0].to_f,a[1].to_f
      results << {
        :name => happening.event.name, 
        :lat => lat, 
        :lng => lng, 
        :url => "/events/#{happening.event.to_param}",
        :location => happening.location.city_state_country,
        :date => happening.start_at.strftime("%b %Y")
      } if happening.location.present?
    end

    File.open(Happening.locations_file, 'w') do |out|
      YAML.dump(results, out)
    end

    puts "Wrote #{results.size} locations to #{Happening.locations_file}"
  end
end