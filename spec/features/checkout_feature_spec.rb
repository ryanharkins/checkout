require 'checkout'
require 'item'
require 'multi_buy_promotion'
require 'total_percentage_promotion'

feature 'Checkout feature' do
  let(:item_1) { Item.new(code: '001', name: 'Lavender heart', price: 9.25) }
  let(:item_2) { Item.new(code: '002', name: 'Personalised cufflinks', price: 45) }
  let(:item_3) { Item.new(code: '003', name: 'Kids T-shirt', price: 19.95) }

  let(:promo_1) { MultiBuyPromotion.new(code: '001', min_buy: 2, new_price: 8.5) }
  let(:promo_2) { TotalPercentagePromotion.new(min_buy: 60, discount_percent: 0.1) }

  let(:promos) { [promo_1, promo_2] }

  subject { Checkout.new(promos) }

  scenario '001, 002, 003' do
    subject.scan(item_1)
    subject.scan(item_2)
    subject.scan(item_3)

    expect(subject.total).to eq 66.78
  end

  scenario '001, 003, 001' do
    subject.scan(item_1)
    subject.scan(item_3)
    subject.scan(item_1)

    expect(subject.total).to eq 36.95
  end

  scenario '001, 002, 001, 003' do
    subject.scan(item_1)
    subject.scan(item_2)
    subject.scan(item_1)
    subject.scan(item_3)

    expect(subject.total).to eq 73.76
  end
end
