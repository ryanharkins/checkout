require 'total_percentage_promotion'

describe TotalPercentagePromotion do
  subject { described_class.new(min_buy: 20, discount_percent: 0.5) }

  context 'when no items are passed' do
    it { expect(subject.discount(0)).to eq 0 }
  end

  context 'when there is a total but does not qualify for discount' do
    it { expect(subject.discount(10)).to eq 0 }
  end

  context 'when the total qualifies for a discount' do
    it { expect(subject.discount(20)).to eq 10.0 }
  end
end
