require 'mechanize'

agent = Mechanize.new

page = agent.get('http://rubyrogues.com/episode-guide/')

agent.pluggable_parser.default = Mechanize::Download

page.links_with(:text => /\d\d\d RR/).each do |link|
  puts "Testing " + link.text + "..."
  if !Dir.entries(ENV['RROGUES_HOME']).include? (link.text + '.mp3')
    puts "Downloading " + link.text + "..."
    following_page = link.click
    link_href = following_page.links_with(:text => 'Download')[0].href
    agent.get(link_href).save(ENV['RROGUES_HOME'] + link.text + '.mp3')
  end
end