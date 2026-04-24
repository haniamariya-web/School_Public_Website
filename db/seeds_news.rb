# Seed only news (does NOT delete existing data)
puts "Creating news..."

news_items = [
  {
    title: "Coming Soon: Fun Carnival 2026",
    content: "Get ready for the most anticipated event of the year! Join us for a spectacular day where the Britain International School System transforms into a world of excitement and wonder.",
    published_at: DateTime.new(2026, 4, 9, 10, 0, 0),
    campus_id: Campu.where(name: "Al-Muqeet Campus").first&.id
  },
  {
    title: "Hifz ul Quran Admissions Started 2026-2027",
    content: "Admissions for our specialized Hifz-ul-Quran Program (2026-2027) are now officially open.",
    published_at: DateTime.new(2026, 4, 6, 9, 0, 0),
    campus_id: Campu.where(name: "Al-Muqeet Campus").first&.id
  },
  {
    title: "Outstanding Matriculation Results 2026",
    content: "Our student Muhammad Ahmed secured 2nd position in Lahore Board Matriculation examinations 2026 with 1086/1100 marks.",
    published_at: DateTime.new(2026, 4, 15, 14, 30, 0),
    campus_id: nil
  },
  {
    title: "Parent-Teacher Meeting Schedule",
    content: "Annual Parent-Teacher Meeting scheduled for Saturday, May 2nd, 2026 from 9:00 AM to 4:00 PM across all campuses.",
    published_at: DateTime.new(2026, 4, 20, 8, 0, 0),
    campus_id: nil
  },
  {
    title: "Chairman's Visit to Al-Muqeet Campus",
    content: "Chairman will visit Al-Muqeet Campus on Friday, April 25th, 2026. Parents welcome at 2:00 PM in the main auditorium.",
    published_at: DateTime.new(2026, 4, 18, 11, 0, 0),
    campus_id: Campu.where(name: "Al-Muqeet Campus").first&.id
  }
]

news_items.each do |item|
  News.find_or_create_by!(title: item[:title]) do |news|
    news.content = item[:content]
    news.published_at = item[:published_at]
    news.campus_id = item[:campus_id]
  end
end

puts "News seeding complete. Total news: #{News.count}"
