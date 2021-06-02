require 'Oystercard'

describe Oystercard do

  it 'shows oystercard balance' do
    expect(subject.balance).to eq 0
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

  context '#deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct money from oystercard' do
      subject.top_up(10)
      expect{ subject.deduct(5) }.to change{ subject.balance }.by (-5)
    end

  end

  context '#in_journey?' do

    it { is_expected.to respond_to(:in_journey?) }

    it 'displays false when not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'displays true when touched in' do
      subject.top_up(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'displays false when touched out' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    context '' do

      it "can't touch in if below minimum balance" do
        expect { subject.touch_in }.to raise_error "The minimum balance required to touch in is £#{Oystercard::MIN_BALANCE}"
      end

    end
  
  end

end
