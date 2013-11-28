require 'spec_helper'
require 'downloader'

describe 'Downloader' do 

  let (:episode_list) {}

  it "appends an entry to the episode list" do 
    downloader = Downloader.new(nil)
    file = double('file')
    File.should_receive(:open).with(ENV['RROGUES_FILE_LOCATION'], "a+").and_yield(file)
    file.should_receive(:<<).with("new_filename\n")    

    downloader.append_entry "new_filename"
  end
  
end