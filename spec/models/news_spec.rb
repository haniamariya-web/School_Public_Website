require 'rails_helper'

RSpec.describe News, type: :model do
  describe 'validations' do
    it 'is valid with a title and content' do
      news = News.new(title: 'Breaking News', content: 'Something happened.')
      expect(news).to be_valid
    end

    it 'is invalid without a title' do
      news = News.new(title: nil)
      news.valid?
      expect(news.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without content' do
      news = News.new(content: nil)
      news.valid?
      expect(news.errors[:content]).to include("can't be blank")
    end
  end

  describe 'callbacks' do
    it 'sets published_at before saving if not present' do
      news = News.new(title: 'Test', content: 'Test')
      news.save
      expect(news.published_at).to be_present
    end
  end

  describe 'scopes' do
    it 'returns only published news in the published scope' do
      published_news = News.create!(title: 'Pub', content: 'Pub', published_at: 1.day.ago)
      future_news = News.create!(title: 'Future', content: 'Future', published_at: 1.day.from_now)
      
      expect(News.published).to include(published_news)
      expect(News.published).not_to include(future_news)
    end
  end
end
