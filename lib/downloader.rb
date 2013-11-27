class Downloader

  attr_accessor :agent

  def initialize(agent_param)
    @agent = agent_param
  end

  def download_file(link)
    following_page = link.click    
    link_href = following_page.links_with(text: 'Download')[0].href
    agent.get(link_href).save(ENV['RROGUES_HOME'] + link.text + '.mp3')
    append_entry(link.text + '.mp3')
  end

  def append_entry(filename)
    File.open(ENV['RROGUES_FILE_LOCATION'], "a+") do |file|
      file << filename + "\n"
    end
  end

  def populate_files_list    
    File.open(ENV['RROGUES_FILE_LOCATION'], "a+") do |file|
      Dir.entries(ENV['RROGUES_HOME']).each do |filename|      
        file << filename + "\n"
      end
    end
  end
end
