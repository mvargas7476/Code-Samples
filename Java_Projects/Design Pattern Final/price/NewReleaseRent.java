
package ood.homeworkFinal.price;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class NewReleaseRent extends PriceStrategy {
    final private double dailyCost = 3.00;             // Initial cost per day
    
    @Override
    public double price(int days) {
        return dailyCost * days;
    }  
}
