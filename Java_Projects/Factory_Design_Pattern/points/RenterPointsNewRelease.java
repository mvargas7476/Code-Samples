
package ood.homework4.points;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class RenterPointsNewRelease extends RenterPointsStrategy {

    @Override
    public int renterPoints(int days) {
        if( days > 1)
            return 2;
        return 1;
    }
    
}
