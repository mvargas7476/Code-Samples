
package ood.homeworkFinal.price;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class VideoGameRental extends PriceStrategy {

    @Override
    public double price(int days) {
        return 2.5 * days;
    }
    
}
