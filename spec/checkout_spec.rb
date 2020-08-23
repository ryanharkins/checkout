require 'checkout'
require 'item'
require 'multi_buy_promotion'

describe Checkout do
  let(:promotional_rules) { [] }
  let(:item_1) { Item.new(code: '001', name: 'Lavender heart', price: 9.25) }
  let(:item_2) { Item.new(code: '002', name: 'Personalised cufflinks', price: 45) }

  subject { described_class.new(promotional_rules) }

  it 'can read promotional_rules' do
    expect(subject).to respond_to(:promotional_rules)
  end

  it 'can read scanned_products' do
    expect(subject).to respond_to(:scanned_products)
  end

  describe '#scan' do
    it 'adds the item to the basket' do
      subject.scan(item_1)
      subject.scan(item_2)

      expect(subject.scanned_products).to eq([item_1, item_2])
    end
  end

  describe '#total' do
    context 'when no items have been scanned' do
      it 'returns 0' do
        expect(subject.total).to eq 0
      end
    end

    context 'when items have been scanned' do
      before do
        subject.scan(item_1)
      end

      it 'totals up all the items' do
        expect(subject.total).to eq 9.25
      end

      describe 'when there are promotions' do
        let(:promotional_rules) { [MultiBuyPromotion.new(code: '001', min_buy: 2, new_price: 8.5)] }

        before do
          subject.scan(item_1)
          subject.scan(item_1)
        end

        it 'discounts the price according to the promotions' do
          expect(subject.total).to eq 25.5
        end
      end
    end
  end
end
