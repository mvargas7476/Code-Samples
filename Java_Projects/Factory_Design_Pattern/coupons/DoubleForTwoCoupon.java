
package ood.homework4.coupons;

import java.util.Enumeration;
import java.util.Vector;

import ood.homework4.Customer;
import ood.homework4.Rental;
import ood.homework4.points.*;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class DoubleForTwoCoupon extends Coupon {
    // This coupon doubles points if there are more than one catagory
    @Override
    public void applyCoupon(Vector _rentals, Customer cust) {
        if(  this.validateCoupon( _rentals, cust ) ) {
            Enumeration rentals = _rentals.elements();
            while( rentals.hasMoreElements() ) {
                Rental rental = (Rental) rentals.nextElement();
                rental.setPointsStrategy(
                    RenterPointsStrategyFactory.buildDouble(rental.getMovie()));
            }
        }
    }
    public boolean validateCoupon(Vector _rentals, Customer cust ) {
        Vector rentedTypes = new Vector();
        // Tests to see if coupon is valid for the rental list
        Enumeration rentals = _rentals.elements();
        while (rentals.hasMoreElements()) {
            Rental rental       = (Rental) rentals.nextElement();
            if(!rentedTypes.contains( rental.getMovie().getType().toString() )) {
                rentedTypes.add( rental.getMovie().getType().toString() );
            }
        }
        return rentedTypes.size() > 1 ;
    }
}
