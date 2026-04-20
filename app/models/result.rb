class Result < ApplicationRecord
  belongs_to :campus, class_name: "Campu"
end
