
package ood.homeworkFinal.price;

/**
 * The PriceStrategy Used when we are giving something free due a promotion 
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class Free extends PriceStrategy {
   
    @Override
    public double price(int days) {
        return 0;
    }
    
}
