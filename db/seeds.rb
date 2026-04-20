# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#AdminUser.create!(email: 'admin@school.com', password: 'password123', password_confirmation: 'password123', admin_code: 'ADMIN001')



# Clear existing data
puts "Clearing existing data..."
Post.destroy_all
Album.destroy_all
AlbumPost.destroy_all
Result.destroy_all
Campu.destroy_all

# Create Campuses
puts "Creating campuses..."
campuses = [
  # Premium Campuses
  { name: "Al-Hayee Campus", address: "Model Town, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Nafay Campus", address: "DHA, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Wasay Campus", address: "WAPDA Town, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Ahad Campus", address: "Buch Villas, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  
  # Sub-Premium Campuses
  { name: "Al-Mustafa Premium Campus-1", address: "Gulshan Market, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Mustafa Premium Campus-2", address: "Masoom Shah Road, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Mujtaba Campus", address: "Nusrat Shaheed Road, Mumtazabad, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Muhammad Campus", address: "New Sabzazar Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Ahmad Campus", address: "Shareef Mall, Katchery Road, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Kareem Campus", address: "18-A, Officers Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Bari Campus", address: "196 Taunsa Street, Garden Town, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  
  # Multan Campuses
  { name: "Al-Samee Campus", address: "Officers Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Noor Campus", address: "Nasheman Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Shakoor Campus", address: "Lodhi Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Ghafoor Campus", address: "Abdali Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Jalil Campus", address: "Hassan Parwana Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Haq Campus", address: "Officers Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Awwal Campus", address: "Officers Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Musawwir Campus", address: "Tehsil Chowk, Bosan Road, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Rehman Campus", address: "Peer Khursheed Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Raheem Campus", address: "Major Tufail Shaheed Road, Shamsabad Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Khaliq Campus", address: "Taunsa Road, Garden Town, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Salam Campus", address: "Zakariya Town, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Mateen Campus", address: "Shah Rukhn E Alam Housing Scheme, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Qawi Campus", address: "Shah Rukhn E Alam Housing Scheme, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  
  # Colleges
  { name: "BICN Boys", address: "Officers Colony, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "BICN Girls", address: "Tehsil Chowk, Bosan Road, Multan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Fatima Ali" },
  
  # Out of Station Campuses
  { name: "Al-Basit Campus", address: "9-10, Irshad Colony, Khanewal", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Samad Campus", address: "Opposite Nishane Haider Petrol Pump, Near Tableghi Markaz Khanewal", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Jameel Campus", address: "25 Block-W, Peoples Colony, Khanewal", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Mehmood Campus", address: "465-XJ, Garden Road, Muzaffar Garh", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Muqeet Campus", address: "566-567, Block G Phase 1 Johar Town, Lahore", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Aziz Campus", address: "Officers Colony, Dunya Pur", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Zahir Campus", address: "7/8, Lakkar Mandi, Opposite Telephone Exchange, Jahaniyan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Hadi Campus", address: "Near Govt. Girls High School Ward # 8, Colony Road, Mailsi", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Rauf Campus", address: "New Model Town, Stadium Road, Burewala", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Razzaq Campus", address: "Multan Road, Mian Channu", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Malik Campus", address: "8 Stadium Road, New Officers Colony, Rahim Yar Khan", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Wahab Campus", address: "55, Employees Colony, Layyah", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Qadir Campus", address: "Bodla Colony, Opp. Govt. High School No 1, Rajanpur", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Habib Campus", address: "52-School Colony, Behind Arts Council, Larkana", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" },
  { name: "Al-Rafay Campus", address: "Magsi Chowk, Multan Road, Shujabad", phone: "+92 61 6510477", email: "info@british.edu.pk", principal_name: "Prof. Ahmad Raza" }
]

campuses.each do |campus_data|
  Campu.create!(campus_data)
end

puts "Created #{Campu.count} campuses"

# Create sample posts
puts "Creating posts..."
posts = [
  {
    title: "Admissions Open 2025-2026",
    content: "Admissions are now open for all campuses. Limited seats available. Last date: April 30th, 2025",
    post_type: :text,
    campus: Campu.first,
    published_at: Time.current
  },
  {
    title: "Annual Sports Day 2025 - Photo Gallery",
    content: "Check out photos from our Annual Sports Day",
    post_type: :image,
    campus: Campu.second,
    published_at: Time.current
  },
  {
    title: "Virtual Parent-Teacher Meeting Recording",
    content: "Watch the recording of our recent parent-teacher meeting",
    post_type: :video,
    campus: Campu.third,
    published_at: Time.current
  }
]

posts.each do |post_data|
  Post.create!(post_data)
end

puts "Created #{Post.count} posts"


# Create sample albums
puts "Creating albums..."
albums = [
  {
    title: "Sports Day 2024",
    description: "Highlights from Sports Day 2024 across all campuses",
    campus: Campu.first,
    event_date: Date.new(2024, 12, 15)
  },
  {
    title: "Independence Day Celebrations",
    description: "Flag hoisting and cultural events",
    campus: Campu.second,
    event_date: Date.new(2024, 8, 14)
  }
]

albums.each do |album_data|
  Album.create!(album_data)
end

puts "Created #{Album.count} albums"

# Create sample results
puts "Creating results..."
results = [
  {
    student_name: "Ali Raza",
    roll_number: "2024-001",
    level: "Grade 10",
    obtained_marks: 850,
    total_marks: 1100,
    grade: "A",
    academic_year: "2024",
    campus: Campu.first
  },
  {
    student_name: "Sara Khan",
    roll_number: "2024-002",
    level: "Grade 10",
    obtained_marks: 920,
    total_marks: 1100,
    grade: "A+",
    academic_year: "2024",
    campus: Campu.first
  }
]

results.each do |result_data|
  Result.create!(result_data)
end

puts "Created #{Result.count} results"


# Create admin user if not exists
if AdminUser.count == 0
  puts "Creating admin user..."
  AdminUser.create!(
    email: "admin@school.com",
    password: "password123",
    password_confirmation: "password123"
  )
  puts "Admin created: admin@school.com / password123"
else
  puts "Admin user already exists"
end

puts "\n=== Seeding Complete ==="
puts "Summary:"
puts "- #{Campu.count} campuses"
puts "- #{Post.count} posts"
puts "- #{Album.count} albums"
puts "- #{Result.count} results"
puts "- #{Inquiry.count} inquiries"
puts "- #{AdminUser.count} admin users"
