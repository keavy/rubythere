Factory.define :event do |f|
  f.name          "A Ruby Conference"
  f.url           "http://www.conf.com"
  f.twitter       "arubyconf"
  f.description   "About text..."
  f.association   :submitter
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
  f.email                 "mail@example.com"
  f.password              "test"
  f.password_confirmation "test"
  #f.password_salt { salt = User.unique_token }
  #f.crypted_password { |s| Authlogic::Sha512CryptoProvider.encrypt("some secret value" + s.password_salt) }
  #f.persistence_token "6cde0674657a8a313ce952df979de2830309aa4c11ca65805dd00bfdc65dbcc2f5e36718660a1d2e68c1a08c276d996763985d2f06fd3d076eb7bc4d97b1e317"
end

Factory.define :submitter do |f|
  f.email                 "mail@example.com"
  f.first_name            "John"
  f.last_name             "Smith"
end