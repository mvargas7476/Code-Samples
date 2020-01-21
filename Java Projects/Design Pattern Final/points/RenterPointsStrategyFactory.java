
package ood.homeworkFinal.points;

import ood.homeworkFinal.item.Item;

/**
 *
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class RenterPointsStrategyFactory {
  
    // Set Points based on Item strategy
    static public RenterPointsStrategy build( Item item ) {
        switch( item.getItemType() ) {
            case NEW_RELEASE_MOVIE:
                return new NewRleasePoints();
            case CHILDRENS_MOVIE:
            case REGULAR_MOVIE:
                return new DefaultPoints();
            case XBOX_GAME:
            case PS4_GAME:
                return new VideoGamePoints();    
            
            // No points are offered for anything else               
            default:
                return new ZeroPoints();
        }
    } 
    
    // Build "double" points strategies (For double points Coupon)
    static public RenterPointsStrategy buildDouble( Item item  ) {
        switch( item.getItemType() ) {
            case NEW_RELEASE_MOVIE:
                return new DoubleNewReleasePoints();
            case CHILDRENS_MOVIE:
            case REGULAR_MOVIE:
                return new DoublePoints();
                
            // No Points are offered for everyitng else               
            default:
                return new ZeroPoints();                
        }
    }     
}
