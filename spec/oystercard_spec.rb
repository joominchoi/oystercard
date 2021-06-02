require 'Oystercard'

describe Oystercard do

  it 'shows oystercard balance' do
    expect(subject.balance).to eq 0
  end

  it 'can top-up oystercard' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it 'enforces maximum balance of 90' do
    expect { subject.top_up 91 }.to raise_error("The card limit is £#{Oystercard::LIMIT}")
  end

end