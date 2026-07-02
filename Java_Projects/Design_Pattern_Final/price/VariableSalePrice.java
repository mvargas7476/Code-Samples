
package ood.homeworkFinal.price;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class VariableSalePrice extends PriceStrategy {
    private Double FixedCost;
    @Override
    public double price(int days) {
        return FixedCost;
    }
    public void setPrice(double NewPrice ) {
        FixedCost = NewPrice;
    }
}

