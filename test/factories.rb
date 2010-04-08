Factory.sequence(:email) { |n| "person#{n}@example.com" }
Factory.sequence(:twitter) { |n| "tname#{n}" }

Factory.define :event do |f|
  f.name          "A Ruby Conference"
  f.url           "http://www.conf.com"
  f.twitter       { Factory.next(:twitter) }
  f.description   "About text..."
  f.association   :submitter
  f.approved      true
end

Factory.define :happening do |f|
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

Factory.define :location do |f|
  f.city          "Glasgow"
  f.country       "UK"
end

Factory.define :venue do |f|
  f.name         "A big hall"
  f.association  :location
end

Factory.define :user do |f|
  f.email                 { Factory.next(:email) }
  f.password              "test"
  f.password_confirmation "test"
end

Factory.define :submitter do |f|
  f.email                 { Factory.next(:email) }
  f.first_name            "John"
  f.last_name             "Smith"
end

Factory.define :speaker do |f|
  f.email                 { Factory.next(:email) }
  f.first_name            "John"
  f.last_name             "Smith"
  f.twitter               { Factory.next(:twitter) }
end

Factory.define :talk do |f|
  f.title                 "topic title"
end

Factory.define :presentation do |f|
  f.association  :speaker
  f.association  :talk
  f.association  :happening
end