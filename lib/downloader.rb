class Downloader

  
  
  def populate_files_list    
    File.open(ENV['RROGUES_FILE_LOCATION'], "a+") do |file|
      Dir.entries(ENV['RROGUES_HOME']).each do |filename|      
        file << filename + "\n"
      end
    end
  end
end
