
package ood.homework4.coupons;

/**
 *
 * @author Robert Diepenbrock
 * @Author Mattias Vargas
 */
public class CouponFactory {
    public enum CouponType {
        DOUBLE_POINTS,
        YOUNG_ADULT_NEW_RELEASE,
        FREE_MOVIE_WITH_POINTS
    }  
    static public Coupon build(CouponType type ) {
        switch(type)  {
            case FREE_MOVIE_WITH_POINTS:
                return new FreeMovieWithPoints();
            case YOUNG_ADULT_NEW_RELEASE:
                return new DoubleForYoungAdults();
            case DOUBLE_POINTS:
            default:
                return new DoubleForTwoCoupon();                
        }
    }
}
