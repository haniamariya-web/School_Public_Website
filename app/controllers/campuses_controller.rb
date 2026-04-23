class CampusesController < ApplicationController
  def index
    all_campuses = Campu.order(:id).to_a
    
    @categories = {
      premium: { title: "Premium Campuses", campuses: [] },
      sub_premium: { title: "Sub-Premium Campuses", campuses: [] },
      multan: { title: "Multan Campuses", campuses: [] },
      colleges: { title: "Our Colleges", campuses: [] },
      out_of_station: { title: "Out-of-Station Campuses", campuses: [] }
    }

    all_campuses.each_with_index do |campus, index|
      if index < 4
        @categories[:premium][:campuses] << campus
      elsif index < 11
        @categories[:sub_premium][:campuses] << campus
      elsif campus.address&.downcase&.include?("multan")
        @categories[:multan][:campuses] << campus
      elsif campus.name&.downcase&.include?("college")
        @categories[:colleges][:campuses] << campus
      else
        @categories[:out_of_station][:campuses] << campus
      end
    end
    
    # Remove any categories that end up empty
    @categories.reject! { |_, data| data[:campuses].empty? }
  end
end
