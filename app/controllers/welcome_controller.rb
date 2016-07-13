class WelcomeController < ApplicationController
  def index
    if params[:summoner_name]
      @match_ids = []
      @players = []
      
      res = HTTParty.get("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{params[:summoner_name]}?api_key=#{ENV['RIOT_API_KEY']}")
      summoner_id = res.parsed_response["#{params[:summoner_name]}"]["id"]
      @summoner_name = res.parsed_response["#{params[:summoner_name]}"]["name"]

      res = HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/#{summoner_id}?rankedQueues=TEAM_BUILDER_DRAFT_RANKED_5x5,RANKED_SOLO_5x5&seasons=PRESEASON3,SEASON3,PRESEASON2014,SEASON2014,PRESEASON2015,SEASON2015,PRESEASON2016,SEASON2016&api_key=#{ENV['RIOT_API_KEY']}")
      res.parsed_response["matches"].each do |match|
        @match_ids << match["matchId"]
      end

      res = HTTParty.get("https://na.api.pvp.net/api/lol/na/v2.2/match/#{@match_ids[0]}?api_key=#{ENV['RIOT_API_KEY']}")
      res.parsed_response["participantIdentities"].each do |player|
        @players << player["player"]["summonerName"]
      end
    end
  end
end
