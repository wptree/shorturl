post '/short/save' do
  json_data = JSON.parse request.body.read
  
  url = json_data['raw_url']
  if url =~ /#{config['raw_url_regex']}/
    digest = Digest::SHA1.new
    sha1 = digest << url
    if redis.exists sha1.to_s
      # if exists, get the number from redis
      number = redis.get sha1.to_s
      base62 = number.alphadecimal
    else
      increased = redis.incr(URL_AUTO_CREMENTAL_KEY)
      redis.set(sha1.to_s,increased)
      base62 = increased.alphadecimal
      redis.set(base62,url)
    end 
    {:status => '0', :result => short_url_prefix + base62.to_s}.to_json
  else
   {:status => '-1', :result => 'invalid url'}.to_json
  end
end

get '/short/:key' do
  if params[:key].nil? 
    {:status => '-1', :result => 'invalid request'}.to_json
  else
    if redis.exists params[:key]
       redirect redis.get(params[:key]), 302
    else
      {:status => '-1', :result => 'the short value dose not exist'}.to_json
    end
  end
end