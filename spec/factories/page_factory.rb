FactoryGirl.define do
  factory :page, class: Page do
    sequence(:name){|i| "page#{i}"}
    locale 'en'
  end
end
