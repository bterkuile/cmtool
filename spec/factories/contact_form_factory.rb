FactoryGirl.define do
  factory :contact_form, class: Cmtool::ContactForm do
    gender 'male'
    email 'contact_form@example.com'
    sequence(:created_at){|i| Time.zone.now + i.seconds} # ensure following created at
  end
end
