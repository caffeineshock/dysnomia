FactoryGirl.define do
  factory :public_channel, class: Channel do
    title 'Offtopic'
  end

  factory :private_channel, class: Channel do
    title 'Super secret'
  end
end