require 'Oystercard'

describe Oystercard do

  let(:station){ double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'shows oystercard balance' do
    expect(subject.balance).to eq 0
  end

  it 'has an empty journey to begin with' do
    expect(subject.journey_list).to be_empty
  end

  context '#top_up' do

    it 'can top-up oystercard' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'enforces maximum balance of 90' do
      expect { subject.top_up(91) }.to raise_error("The card limit is £#{Oystercard::LIMIT}")
    end

  end

  context '#touch_in' do
    
    it "can't touch in if below minimum balance" do
      expect { subject.touch_in(station) }.to raise_error "The minimum balance required to touch in is £#{Oystercard::MIN_BALANCE}"
    end

    it 'remembers entry station after touch in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  
  end
  
  context '#touch_out' do
    
    it 'deducts minimum fare from balance when touched out' do
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MIN_FARE)
    end

    it 'remembers exit station after touch out' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  
  end

  context '#journey_creator' do
    
    it 'stores a journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_list).to include journey
    end

  end

end

