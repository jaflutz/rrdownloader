require 'mechanize'
require 'logger'

agent = Mechanize.new
logger = Logger.new(STDOUT)


page = agent.get('http://rubyrogues.com/episode-guide/')

agent.pluggable_parser.default = Mechanize::Download

page.links_with(text: /\d\d\d RR/).each do |link|
  logger.info 'Testing ' + link.text +  '...'
  unless Dir.entries(ENV['RROGUES_HOME']).include? (link.text + '.mp3')
    logger.info 'Downloading ' + link.text + '...'
    following_page = link.click
    link_href = following_page.links_with(text: 'Download')[0].href
    agent.get(link['href']).save(ENV['RROGUES_HOME'] + link.text + '.mp3')
  end
end