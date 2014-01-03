User Ruby + Sinatra + Redis to service as shorturl server

Send HTTP POST request with body like below to "http://config_domain/short" get the shorturl. The domian is configurable in config.yml. 
{"raw_url":"http://www.google.com"}

If the raw_url is matched the regex in config.yml, The response should be <br\>
{"status":0, "result": "http://config_domain/1"}.<br\>
If the raw_url is illegal, the response should be <br\>
{"status":0, "result": "invalid url"}.<br\>

Then visit "http://config_domain/1", it will jump to "http://www.google.com".
