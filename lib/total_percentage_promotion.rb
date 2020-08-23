class TotalPercentagePromotion
  def initialize(min_buy:, discount_percent:)
    @min_buy, @discount_percent = min_buy, discount_percent
  end

  def basket_promotion?
    true
  end

  def discount(basket_total = 0)
    return 0 if basket_total < @min_buy

    basket_total.to_f * @discount_percent
  end
end
