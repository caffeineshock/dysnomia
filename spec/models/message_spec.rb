require 'spec_helper'

describe Message, '#unread_by' do
  context 'for public channel' do
    it 'should return a message if there is one from another user'
    it 'should return nothing if there is one message from self' 
  end
end

describe Message, '#last_in_channel' do
  it 'should return date time of message'
  it 'should return nil if no message present'
end