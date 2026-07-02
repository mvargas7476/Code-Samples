
package ood.homework4.coupons;

import java.util.Enumeration;
import java.util.Vector;
import ood.homework4.Customer;
import ood.homework4.Rental;
import ood.homework4.points.RenterPointsStrategyFactory;
import ood.homework4.price.PriceStrategyFactory;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class FreeMovieWithPoints extends Coupon {

    @Override
    public void applyCoupon(Vector _rentals, Customer cust) {
       if( validateCoupon(_rentals, cust)) {
           // The customer has points to use!  Pick the movie to get for free.
            Enumeration rentals = _rentals.elements();
            Rental maxRental = null;
            while( rentals.hasMoreElements() ) {
                Rental rental = (Rental) rentals.nextElement();
                if( (maxRental == null ) || (maxRental.getCost() < rental.getCost()) )
                    maxRental = rental;
            }
            if( (maxRental != null )) {
                maxRental.setPriceStrategy(PriceStrategyFactory.Type.FREE);
                cust.setPoints( cust.getPoints() - 10 );
            }
       }
    }

    @Override
    public boolean validateCoupon(Vector _rentals, Customer cust) {
        if( cust.getPoints() >= 10 )
            return true;
        return false;
    }
    
}
