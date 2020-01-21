
package ood.homework4.coupons;

import java.util.Vector;
import ood.homework4.Customer;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public abstract class Coupon {
    public abstract void applyCoupon( Vector _rentals, Customer cust );
    public abstract boolean validateCoupon(Vector _rentals, Customer cust ); 
}
