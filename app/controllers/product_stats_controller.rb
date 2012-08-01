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

    for i in (0...@count)
      @num = @result["#{i}".to_i]["uv_count"]
      @den = @result["#{i}".to_i]["target_uv"]
      @per = (@num * 100.0) / @den
      @per = @per.round(1)
    end
  end

  def get_community
    sgsign = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.sg.signup.count&format=json"
    insign = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.in.signup.count&format=json"
    ausign = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.au.signup.count&format=json"
    phsign = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.ph.signup.count&format=json"

    sgsub = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.sg.subscribers.subscribed.count&format=json"
    insub = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.in.subscribers.subscribed.count&format=json"
    ausub = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.au.subscribers.subscribed.count&format=json"
    phsub = "http://stats.internal.says.com/render?target=stats.gauges.says-global.production.ph.subscribers.subscribed.count&format=json"

    sign_sg = Net::HTTP.get_response(URI.parse(sgsign))
    sign_in = Net::HTTP.get_response(URI.parse(insign))
    sign_au = Net::HTTP.get_response(URI.parse(ausign))
    sign_ph = Net::HTTP.get_response(URI.parse(phsign))

    sub_sg = Net::HTTP.get_response(URI.parse(sgsub))
    sub_in = Net::HTTP.get_response(URI.parse(insub))
    sub_au = Net::HTTP.get_response(URI.parse(ausub))
    sub_ph = Net::HTTP.get_response(URI.parse(phsub))

    @signsg = JSON.parse(sign_sg.body)
    @signin = JSON.parse(sign_in.body)
    @signau = JSON.parse(sign_au.body)
    @signph = JSON.parse(sign_ph.body)

    @subsg = JSON.parse(sub_sg.body)
    @subin = JSON.parse(sub_in.body)
    @subau = JSON.parse(sub_au.body)
    @subph = JSON.parse(sub_ph.body)
  end
end

#photo_url for picture