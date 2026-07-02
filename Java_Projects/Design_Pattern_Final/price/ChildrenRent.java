
package ood.homeworkFinal.price;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class ChildrenRent extends PriceStrategy {
    final private double dailyCost = 0.5;             // Initial cost per day

    @Override
    public double price(int days) {
        return dailyCost * days;
    }
    
}
