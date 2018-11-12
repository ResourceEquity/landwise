task :wash_dishes => :environment  do
	puts "Starting Dishwasher Cycle"
	Dishwasher.run
	puts "Cycle Ended"
end

task :reindex_all => :environment do
	system "cd #{Rails.root} && rake environment tire:import CLASS='Item' FORCE=true"
end

namespace :landesa do
	task :notify => :environment do
		Notification.send_all
	end
end