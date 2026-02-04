
package ood.homework4.price;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class PriceRegular extends PriceStrategy {
    final private double dailyCost = 1.00;             // Initial cost per day
    final private int extendedDays = 2;                // Initial cost period
    final private double extendedDailyCost = 1.50;     // Extended cost per day
    
    @Override
    public double rentalCost(int days) {
        double returnValue = dailyCost;
        if (days > extendedDays) {
            returnValue += (days - extendedDays) * extendedDailyCost;
        }
        return returnValue;
    }
    
}
