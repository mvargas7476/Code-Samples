
package ood.homework4.price;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class PriceNewRelease extends PriceStrategy {
    final private double dailyCost = 3.00;             // Initial cost per day
    
    @Override
    public double rentalCost(int days) {
        return dailyCost * days;
    }  
}
