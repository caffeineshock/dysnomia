require 'spec_helper'

describe Event, "#between" do
  before(:each) { Timecop.freeze }

  it "should only return events in specified timespan" do
  	all_events = (0..3).map { |i| create(:event, starts_at: (i + 1).days.ago, ends_at: i.days.ago) }

  	events = Event.between 3.days.ago.to_s, 1.day.ago.to_s
    events.each { |e| puts "#{e.starts_at}-#{e.ends_at}"}
    expected_events = all_events.reject { |e| e.starts_at < 3.days.ago or e.starts_at > 1.day.ago }

  	expect(events).to match_array(expected_events)
  end
end

describe Event, ".recurring?" do
  context "with recurrence" do
    %w{weekly daily yearly}.each do |r|
      subject { build("#{r}_recurring_event".to_sym) }

      it "should return true if recurring #{r}" do  
        expect(subject.recurring?).to be true 
      end
    end
  end

  context "without recurrence" do
    subject { build(:event) }

    it "should return false" do
      expect(subject.recurring?).to be false 
    end
  end
end

describe Event, ".schedule_exceptions" do
  context "without exception" do
    subject { build(:event) }

    it "should return no exceptions" do
      expect(subject.schedule_exceptions).to match_array([])
    end
  end

  context "with exception" do
    %w{weekly daily yearly}.each do |r|
      subject { build("#{r}_recurring_event".to_sym) }

      it "should return a single exception" do
        Timecop.freeze do
          subject.add_exception(Time.now)
          expect(subject.schedule_exceptions).to match_array([Time.now])
        end
      end
    end
  end
end

describe Event, ".occurences_between" do
  before(:each) { Timecop.freeze }

  context "with daily recurrence" do
    subject { build(:daily_recurring_event, starts_at: 3.days.ago, ends_at: 2.days.ago) }

    it "should return recurring events correctly" do
      result = subject.occurences_between 3.days.ago, 1.day.ago
      expect(result.size).to eq(3)
    end
  end

  context "with weekly recurrence" do
    subject { build(:weekly_recurring_event, starts_at: 14.days.ago, ends_at: 13.days.ago) }

    it "should return recurring events correctly" do
      result = subject.occurences_between 14.days.ago, Time.now
      expect(result.size).to eq(3)
    end
  end

  context "with yearly recurrence" do
    subject { build(:yearly_recurring_event, starts_at: 2.years.ago, ends_at: 2.years.ago + 1.day) }

    it "should return recurring events correctly" do
      result = subject.occurences_between 2.years.ago, Time.now
      expect(result.size).to eq(3)
    end
  end

  context "without recurrences" do
    subject { build(:event, starts_at: 3.days.ago, ends_at: 2.days.ago) }

    it "should return single event if start date is in between timespan" do
      result = subject.occurences_between 4.days.ago, 2.day.ago
    	expect(result).to match_array([subject])
    end

    it "should return empty array if start date is outside of timespan" do
      result = subject.occurences_between 2.days.ago, 1.day.ago
      expect(result).to match_array([])
    end
  end 
end