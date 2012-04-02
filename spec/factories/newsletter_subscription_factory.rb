FactoryGirl.define do
  factory :newsletter_subscription, class: Cmtool::NewsletterSubscription do
    sequence(:created_at){|i| Time.zone.now + i.seconds} # ensure following created at
    sequence(:email){ |i| "subscriber#{i}@example.com" }
  end
end
