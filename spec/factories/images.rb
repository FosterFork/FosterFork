FactoryGirl.define do
  factory :image do
    project
    image { File.new(Rails.root.join('spec/files/1x1.jpg')) }
    alt "alt"
  end
end
