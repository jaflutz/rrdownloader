require 'spec_helper'
require 'episode_list'

describe "EpisodeList" do 

  let(:episode) {"episode_test"}
  let(:empty_episode_list) {Array.new}
  let(:filled_episode_list) {Array.new(1, "episode_test")}
  let(:episode_list) {EpisodeList.new (ENV['RROGUES_FILE_LOCATION'])}
  
  it "downloads a non existent file" do    
    episode_list.stub(:episodes).and_return(empty_episode_list)
    expect(episode_list.contains_file?(episode)).to be_false
  end

  it "do not download an existent file" do
    episode_list.stub(:episodes).and_return(filled_episode_list)    
    expect(episode_list.contains_file?(episode)).to be_true
  end

  it "reads an existent file location" do
    mock_file = double('File')
    mock_file.should_receive(:file?).twice.with(ENV['RROGUES_FILE_LOCATION']).and_return(true)
    mock_file.should_receive(:read).twice.with(ENV['RROGUES_FILE_LOCATION']).and_return("episode_test")
    
    episode_list = EpisodeList.new(ENV['RROGUES_FILE_LOCATION'], mock_file)

    expect(episode_list.read_episodes_file(ENV['RROGUES_FILE_LOCATION'], mock_file)).to eq(["episode_test"])
  end

  it "reads an inexistent file location" do
    mock_file = double('File')
    mock_file.should_receive(:file?).twice.with(ENV['RROGUES_FILE_LOCATION']).and_return(false)    
    
    episode_list = EpisodeList.new(ENV['RROGUES_FILE_LOCATION'], mock_file)

    expect(episode_list.read_episodes_file(ENV['RROGUES_FILE_LOCATION'], mock_file)).to eq([])
  end
  
end