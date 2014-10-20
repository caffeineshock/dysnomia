FactoryGirl.define do
  factory :tenant, class: Tenant do
    hostname 'localhost'
    name 'Test'
    id 1
  end
end