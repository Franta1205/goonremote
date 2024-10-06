# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

# Clear existing data
Job.destroy_all
Company.destroy_all
User.destroy_all

# Create some dummy users
users = []
5.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: "password"
  )
end

User.create!(
  email: "admin@gmail.com",
  password: "password",
  admin: true
)

# Create dummy companies associated with random users
companies = []
30.times do
  companies << Company.create!(
    name: Faker::Company.name,
    description: Faker::Company.catch_phrase,
    career_page: Faker::Internet.url,
    website_url: Faker::Internet.url,
    linkedin: Faker::Internet.url,
    x: Faker::Internet.url, # Placeholder for social media handle (e.g., Twitter/X)
    user: users.sample, # Associate with a random user
    logo: nil
  )
end

# Seed jobs for the companies
companies.each do |company|
  rand(7..10).times do # Create 3 to 7 jobs per company
    Job.create!(
      title: Faker::Job.title,
      description: Faker::Lorem.paragraph(sentence_count: 5), # Generate a random job description
      location: Locations::COUNTRIES.sample[1], # Random location type
      apply_link: Faker::Internet.url,
      currency: ["$", "€", "£"].sample, # Random currency
      salary_min: rand(30_000..50_000), # Random minimum salary
      salary_max: rand(60_000..100_000), # Random maximum salary
      employment_type: %w[full_time part_time contract].sample, # Random employment type
      experience: %w[junior mid-level senior].sample, # Random experience level
      company:, # Associate job with company
      created_at: rand(30.days).seconds.ago,
      updated_at: Time.now,
      published_at: [rand(Time.now.beginning_of_month..Time.now), # Random date this month
                    rand(1.month.ago.beginning_of_month..1.month.ago.end_of_month), # Random date last month
                    nil].sample
    )
  end
end

puts "Seeding completed!"
