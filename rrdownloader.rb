require 'mechanize'
require 'logger'
require_relative 'lib/downloader.rb'
require_relative 'lib/episode_list.rb'

agent = Mechanize.new
logger = Logger.new(STDOUT)

page = agent.get('http://rubyrogues.com/episode-guide/')

agent.pluggable_parser.default = Mechanize::Download

episode_list = EpisodeList.new(ENV['RROGUES_FILE_LOCATION'])
downloader = Downloader.new(agent)

page.links_with(text: /\d\d\d RR/).each do |link|
  logger.info 'Testing ' + link.text +  '...'
  unless episode_list.contains_file?(link.text + '.mp3')
    logger.info 'Downloading ' + link.text + '...'
    downloader.download_file link
  end
end