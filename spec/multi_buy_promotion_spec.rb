require 'item'
require 'multi_buy_promotion'

describe MultiBuyPromotion do
  subject { described_class.new(code: '001', min_buy: 2, new_price: 9.0) }
  let(:item_1) { Item.new(code: '001', name: 'Item 1', price: 9.50) }

  context 'when no items are passed' do
    it 'returns 0' do
      expect(subject.discount([])).to eq 0
    end
  end

  context 'when there are matching items but dont qualify' do
    let(:items) { [item_1] }

    it { expect(subject.discount(items)).to eq 0 }
  end

  context 'when there are matching items that qualify' do
    let(:items) { [item_1, item_1] }

    it { expect(subject.discount(items)).to eq 1 }
  end
end
