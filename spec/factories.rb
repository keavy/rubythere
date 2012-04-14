FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:twitter) { |n| "tname#{n}" }

  factory :event do |f|
    f.name          "A Ruby Conference"
    f.url           "http://www.conf.com"
    f.twitter       { FactoryGirl.generate(:twitter) }
    f.description   "About text..."
    f.association   :submitter
    f.approved      true
  end

  factory :happening do |f|
    f.association  :event
    f.url          "http://www.conf.com/2009/"
    f.start_at     "2009-08-01"
    f.end_at       "2009-08-05"
    f.description  "About text..."
    f.currency     "&pound;"
    f.cost         "195"
    f.association  :location
    f.association  :venue
  end

  factory :location do |f|
    f.city          "Glasgow"
    f.country       "UK"
  end

  factory :venue do |f|
    f.name         "A big hall"
    f.association  :location
  end

  factory :user do |f|
    f.email                 { FactoryGirl.generate(:email) }
    f.screen_name           { FactoryGirl.generate(:twitter) }
  end

  factory :submitter do |f|
    f.email                 { FactoryGirl.generate(:email) }
    f.first_name            "John"
    f.last_name             "Smith"
  end

  factory :speaker do |f|
    f.email                 { FactoryGirl.generate(:email) }
    f.first_name            "John"
    f.last_name             "Smith"
    f.twitter               { FactoryGirl.generate(:twitter) }
  end

  factory :talk do |f|
    f.title                 "topic title"
  end

  factory :presentation do |f|
    f.association  :speaker
    f.association  :talk
    f.association  :happening
  end
end