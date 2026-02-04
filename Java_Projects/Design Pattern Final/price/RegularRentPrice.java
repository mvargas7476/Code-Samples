
package ood.homeworkFinal.price;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class RegularRentPrice extends PriceStrategy {
    final private double dailyCost = 1.00;             // Initial cost per day
    final private int extendedDays = 2;                // Initial cost period
    final private double extendedDailyCost = 1.50;     // Extended cost per day
    
    @Override
    public double price(int days) {
        double returnValue = dailyCost;
        if (days > extendedDays) {
            returnValue += (days - extendedDays) * extendedDailyCost;
        }
        return returnValue;
    }
    
}
