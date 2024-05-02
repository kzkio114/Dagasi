class PriceCalculator
  def self.calculate(product_name)
    match = product_name.match(/(\d+)(本|個|入|点|袋)/)
    return 0 unless match

    quantity = match[1].to_i
    unit = match[2]

    price_per_unit = case unit
                     when '本' then 200
                     when '個' then 100
                     when '入' then 100
                     when '点' then 100
                     when '袋' then 100
                     else 0
                     end

    quantity * price_per_unit
  end
end