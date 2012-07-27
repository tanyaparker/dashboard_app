class ProductStatsController < ApplicationController
  def get_features		
  	PivotalTracker::Client.token = '002c98a5157fc9cc5c180766d7c02dbd'
	@project = PivotalTracker::Project.find(582291)
	@project.stories.all(:state => ['started', 'finished', 'delivered', 'rejected'], :type => ['Feature', 'Bug', 'Chore'])
	#@story_type
	#@current_state
	#@name
  end
end