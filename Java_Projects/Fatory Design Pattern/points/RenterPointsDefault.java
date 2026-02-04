
package ood.homework4.points;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class RenterPointsDefault extends RenterPointsStrategy {
    private final int points = 1;  //Default number of points for a rental
    
    @Override
    public int renterPoints(int days) {
        return points ;
    }  
    
}
