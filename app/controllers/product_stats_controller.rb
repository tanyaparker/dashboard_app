class ProductStatsController < ApplicationController
  def get_features		
  	PivotalTracker::Client.token = '002c98a5157fc9cc5c180766d7c02dbd'
	@project = PivotalTracker::Project.find(582291)
	@project.stories.all(:state => ['started', 'finished', 'delivered', 'acccepted', 'rejected'], :type => ['Feature', 'Bug', 'Chore'])
	@count = @project.stories.all.count
	@project.stories.all.sort! { |a,b| b.created_at <=> a.created_at } 
	#@name, story_type, current_state
  end 
end


