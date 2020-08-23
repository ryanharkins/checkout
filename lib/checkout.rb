class Checkout
  attr_reader :promotional_rules, :scanned_products

  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @scanned_products = []
  end

  def scan(item)
    @scanned_products << item
  end

  def total
    return 0 if @scanned_products.empty?

    apply_promotions
  end

  private

  def total_without_discount
    @scanned_products.sum(&:price)
  end

  def apply_promotions
    mutli_buy_discount = multi_buy_promotions.map do |promo|
      promo.discount(scanned_products)
    end.sum

    price_after_discount = total_without_discount - mutli_buy_discount

    basket_promotions.each do |promo|
      price_after_discount -= promo.discount(price_after_discount)
    end

    price_after_discount.round(2)
  end

  def multi_buy_promotions
    promotional_rules.reject(&:basket_promotion?)
  end

  def basket_promotions
    promotional_rules - multi_buy_promotions
  end
end
