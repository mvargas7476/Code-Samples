
package ood.homeworkFinal.points;

/**
 * For when we are not giving points (like when its a sale, not a rental)
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class ZeroPoints extends RenterPointsStrategy {

    @Override
    public int renterPoints(int days) {
        return 0;
    } 
}
