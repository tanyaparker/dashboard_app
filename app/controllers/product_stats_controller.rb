class ProductStatsController < ApplicationController

  def get_features		
  	PivotalTracker::Client.token = '002c98a5157fc9cc5c180766d7c02dbd'
	@project = PivotalTracker::Project.find(582291)
	@new_project =  @project.stories.all(:current_state => ['started', 'finished', 'delivered', 'accepted', 'rejected'])
	@new_project.sort! { |a,b| b.created_at <=> a.created_at }
	@count = @new_project.size
	@final_project = @new_project.slice(0,@count)
	@final_project.sort! { |a,b| a.current_state <=> b.current_state}
  end 
end

#http://dl.dropbox.com/u/7317686/Product_RADAR/css/main.css