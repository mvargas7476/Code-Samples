
package ood.homework4.price;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class PriceChildren extends PriceStrategy {
    final private double dailyCost = 0.5;             // Initial cost per day

    @Override
    public double rentalCost(int days) {
        return dailyCost * days;
    }
    
}
