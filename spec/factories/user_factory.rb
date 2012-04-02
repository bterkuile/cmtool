FactoryGirl.define do
  factory :user, class: User do
    email 'utools-test@example.com'
    password '12345'
    is_admin true
    active true
  end
end
