require 'spec_helper'

describe User, '.can_edit?' do
  context 'as admin' do
  	subject { create(:admin) }

  	it 'should return true for other user' do
      expect(subject.can_edit? create(:user)).to be true
  	end 
  end

  context 'as normal user' do
    subject { create(:user) }

    it 'should return true for self' do
      expect(subject.can_edit? subject).to be true
    end

    it 'should return false for other user' do
      expect(subject.can_edit? create(:other_user)).to be false
    end
  end
end

describe User, '.online?' do
  subject { create(:user) }
  before(:each) { Timecop.freeze }

  it 'should return true if current_sign_in_at < 5.minutes.ago' do
  	subject.current_sign_in_at = 4.minutes.ago
  	expect(subject.online?).to be true
  end

  it 'should return false if current_sign_in_at > 5.minutes.ago' do
    subject.current_sign_in_at = 6.minutes.ago
  	expect(subject.online?).to be false
  end
end

describe User, '.generate_access_token' do
  subject { build(:user) }

  it 'should not be executed before creation' do
  	expect(subject.access_token).to be_nil
  end

  it 'should generate a new token upon creation' do
  	subject.save
  	expect(subject.access_token).not_to be_empty
  end
end