
package ood.homework4.coupons;

import java.util.Enumeration;
import java.util.Vector;
import ood.homework4.Customer;
import ood.homework4.Rental;
import static ood.homework4.Movie.Type.NEW_RELEASE;
import ood.homework4.points.RenterPointsStrategyFactory;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class DoubleForYoungAdults extends Coupon {
    // Double points for young adults who rent at least one New Release
    @Override
    public void applyCoupon(Vector _rentals, Customer cust ) {
        if(  this.validateCoupon( _rentals, cust ) ) {
            Enumeration rentals = _rentals.elements();
            while( rentals.hasMoreElements() ) {
                Rental rental = (Rental) rentals.nextElement();
                rental.setPointsStrategy(
                    RenterPointsStrategyFactory.buildDouble(rental.getMovie()));
            }
        }
    }

    @Override
    public boolean validateCoupon(Vector _rentals, Customer cust) {
        // True if Customer age between 18-21 & they are renting one or more New Release
        Enumeration rentals = _rentals.elements();
        boolean hasNewRelease = false;
        while( rentals.hasMoreElements() ) {
            // Looking for a new release
            Rental rental = (Rental) rentals.nextElement();
            if(rental.getMovie().getType() == NEW_RELEASE ) {
                hasNewRelease = true;
                break;
            }
        }
        return hasNewRelease && (cust.getAge() > 18) && (cust.getAge() < 22);
    }
}
