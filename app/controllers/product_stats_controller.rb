class ProductStatsController < ApplicationController

  def get_features		
  	PivotalTracker::Client.token = '002c98a5157fc9cc5c180766d7c02dbd'
	@project = PivotalTracker::Project.find(582291)
	@project.stories.all(:state => ['started', 'finished', 'delivered', 'acccepted', 'rejected'], :type => ['Feature', 'Bug', 'Chore'])
	@project.stories.all.sort! { |a,b| b.created_at <=> a.created_at }
	@new_project = @project.stories.all.slice(0,50) 
	@new_project.sort! { |a,b| a.current_state <=> b.current_state}
  end 
end

#http://dl.dropbox.com/u/7317686/Product_RADAR/css/main.css