class ProductStatsController < ApplicationController
  def get_features		
  	PivotalTracker::Client.token = '002c98a5157fc9cc5c180766d7c02dbd'
	@project = PivotalTracker::Project.find(582291)
	@project.stories.all(:limit => '10', :offset => '20', :state => ['started', 'finished', 'delivered', 'accepted', 'rejected'], :type => 'Feature')
	#@project.activities.all(:limit => '10')
	@count = @project.stories.all.count
	#@count = @project.activities.all.count
	#@story_type
	#@current_state
	#@name

  end
end

#http://www.xmltoolbox.com/
#https://github.com/jsmestad/pivotal-tracker