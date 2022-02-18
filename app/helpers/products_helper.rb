module ProductsHelper
    def pluralize_product(count)
        if count == 0
            "produków"
        elsif count == 1
            "produkt"
        elsif count >= 2 &&  count <= 4
            "produkty"
        elsif count >= 5
            "produktów"
        end
    end
end
