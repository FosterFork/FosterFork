require 'rails_helper'

RSpec.describe Statistic, type: :model do

  it "can take a snapshot" do
    s = Statistic.snapshot
    expect(s.data[:users]).to eq(User.count)
  end

end
