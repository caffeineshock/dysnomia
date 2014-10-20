FactoryGirl.define do
  factory :user do
    username "Hans"
    email "hans@gmail.com"
    password "supersecret"
    password_confirmation "supersecret"
  end

  factory :other_user, class: User do
    username "Peter"
    email "peter@gmail.com"
    password "supersecret"
    password_confirmation "supersecret"
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    username "Franz"
    email "franz@gmail.com"
    password "supersecret"
    password_confirmation "supersecret"
    role :admin
  end
end