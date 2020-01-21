
package ood.homeworkFinal.points;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class DefaultPoints extends RenterPointsStrategy {
    private final int points = 1;  //Default number of points for a rental
    
    @Override
    public int renterPoints(int days) {
        return points ;
    }  
    
}
