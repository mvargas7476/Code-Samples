
package ood.homeworkFinal.points;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class DoublePoints extends RenterPointsStrategy {
    private final int points = 2; 
    
    @Override
    public int renterPoints(int days) {
        return points ;
    }  
}
