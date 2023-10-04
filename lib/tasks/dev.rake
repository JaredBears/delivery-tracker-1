desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  User.destroy_all
  Package.destroy_all

  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save

    10.times do
      package = Package.new
      package.desc = Faker::Commerce.product_name
      package.expected = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
      package.delivered = Faker::Boolean.boolean(true_ratio: 0.2)
      package.notes = Faker::Lorem.paragraph(sentence_count: 2)
      package.owner_id = User.all.sample.id
      package.save
    end
  end
end
