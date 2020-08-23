class MultiBuyPromotion
  def initialize(code:, min_buy:, new_price:)
    @code, @min_buy, @new_price = code, min_buy, new_price
  end

  def basket_promotion?
    false
  end

  def discount(items)
    matching_items = items.select { |d| d.code == @code }

    return 0 unless matching_items.count >= @min_buy

    old_price = matching_items.sum(&:price)
    new_price = matching_items.count * @new_price

    old_price - new_price
  end
end
