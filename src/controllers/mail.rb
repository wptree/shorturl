mail_domain = config['mail_domain']
api_key = config['mailgun_api_key']

post '/mail/simple' do
  json_data = JSON.parse request.body.read
  RestClient.post "https://api:#{api_key}"\
  "@api.mailgun.net/v2/#{mail_domain}/messages",
  :from => "#{json_data['fromName']} <#{json_data['fromMail']}>",
  :to => "#{json_data['toList']}",
  :subject => "#{json_data['subject']}",
  :text => "#{json_data['text']}"
end

post '/mail/complex' do
  json_data = JSON.parse request.body.read
  data = Multimap.new
  data[:from] = "Excited User <me@samples.mailgun.org>"
  data[:to] = "foo@example.com"
  data[:cc] = "baz@example.com"
  data[:bcc] = "bar@example.com"
  data[:subject] = "Hello"
  data[:text] = "Testing some Mailgun awesomness!"
  data[:html] = "<html>HTML version of the body</html>"
  data[:attachment] = File.new(File.join("files", "test.jpg"))
  data[:attachment] = File.new(File.join("files", "test.txt"))
  RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
  "@api.mailgun.net/v2/#{mail_domain}/messages", data
end
