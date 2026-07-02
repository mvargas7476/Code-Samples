
package ood.homeworkFinal.coupons;

import java.util.Vector;
import ood.homeworkFinal.Customer;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public abstract class Coupon {
    public abstract void applyCoupon( Vector _items, Customer cust );
    public abstract boolean validateCoupon(Vector _items, Customer cust ); 
}
