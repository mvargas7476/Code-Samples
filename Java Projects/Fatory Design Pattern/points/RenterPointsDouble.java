
package ood.homework4.points;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class RenterPointsDouble extends RenterPointsStrategy {
    private final int points = 2; 
    
    @Override
    public int renterPoints(int days) {
        return points ;
    }  
}
