
package ood.homeworkFinal.points;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class NewRleasePoints extends RenterPointsStrategy {

    @Override
    public int renterPoints(int days) {
        if( days > 1)
            return 2;
        return 1;
    }
    
}
