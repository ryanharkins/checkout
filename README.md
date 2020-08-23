## Usage:

```ruby
> irb

# Instantiate products
item_1 = Item.new(code: '001', name: 'Lavender heart', price: 9.25)
item_2 = Item.new(code: '002', name: 'Personalised cufflinks', price: 45)
item_3 = Item.new(code: '003', name: 'Kids T-shirt', price: 19.95)

# Create promotions
promo_1 = MultiBuyPromotion.new(code: '001', min_buy: 2, new_price: 8.5)
promo_2 = TotalPercentagePromotion.new(min_buy: 60, discount_percent: 0.1)
promotional_rules = [promo_1, promo_2]

# Main interface
co = Checkout.new(promotional_rules)
co.scan(item_1)
co.scan(item_2)
co.scan(item_3)

co.total # => 66.78
```

## Development

```ruby
bundle
rspec spec/
```
