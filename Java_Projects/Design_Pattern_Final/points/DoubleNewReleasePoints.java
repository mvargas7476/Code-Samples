
package ood.homeworkFinal.points;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class DoubleNewReleasePoints extends RenterPointsStrategy {

    @Override
    public int renterPoints(int days) {
        if( days > 1)
            return 4;
        return 2;
    }
}