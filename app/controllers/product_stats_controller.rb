require 'rubygems'
require 'json'
require 'net/http'

class ProductStatsController < ApplicationController

  def get_features		
  	PivotalTracker::Client.token = '002c98a5157fc9cc5c180766d7c02dbd'
	@project = PivotalTracker::Project.find(582291)
	@new_project =  @project.stories.all(:current_state => ['started', 'finished', 'delivered', 'accepted', 'rejected'])
	@new_project.sort! { |a,b| b.created_at <=> a.created_at }
	@count = @new_project.size

	if(@count < 10)
	  @final_project = @new_project.slice(0, @count)
    else
      @count = 10 	
	  @final_project = @new_project.slice(0, @count)
	end

	@final_project.sort! { |a,b| a.current_state <=> b.current_state}
  end 

  def get_campaigns

    url = "http://says.com/my/campaigns.json"
    resp = Net::HTTP.get_response(URI.parse(url))
    data = resp.body
    @result = JSON.parse(data)
    @count = @result.size

  end
end

#<%=  @result["#{i}".to_i]["photo_url"] %>