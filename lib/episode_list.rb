class EpisodeList
  
  attr_accessor :episodes

  def initialize(file_location, file_handler=File)
    @episodes = read_episodes_file(file_location, file_handler)    
  end

  def contains_file?(filename)
    episodes.include?(filename)
  end

  #Should be private - not doing for testing exercise
  #private

  def read_episodes_file(file_location, file_handler)
    if file_handler.file? file_location
      file_handler.read(file_location).split(/\n/)
    else       
      []
    end
  end
end