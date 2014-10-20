FactoryGirl.define do
  factory :event do
    starts_at { 1.day.ago }
    ends_at { Time.now }
    title "Some very important event"
    description "Detailed description"
    category_id 1
  end

  %w{weekly daily yearly}.each do |r|
    factory "#{r}_recurring_event".to_sym, class: Event, parent: :event do
      recurring_type { r.to_sym }
    end
  end
end