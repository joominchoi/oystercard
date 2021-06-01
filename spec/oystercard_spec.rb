require "Oystercard"

describe Oystercard do

  it "shows oystercard balance" do
    expect(subject.balance).to eq 0
  end

  it "can top_up oystercard" do
    subject.top_up
    expect(subject.balance).to eq (5)
  end

end