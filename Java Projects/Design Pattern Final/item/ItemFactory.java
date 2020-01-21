
package ood.homeworkFinal.item;

import static ood.homeworkFinal.item.ItemFactory.ItemType.XBOX_GAME;
import static ood.homeworkFinal.item.Movie.MovieTypes.*;
import static ood.homeworkFinal.item.VideoGame.VideoGameTypes.PS4;
import static ood.homeworkFinal.item.VideoGame.VideoGameTypes.XBOX;

/**
 * Factory that builds Items
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class ItemFactory {
    public enum ItemType {
        CHILDRENS_MOVIE,
        NEW_RELEASE_MOVIE,
        REGULAR_MOVIE,
        MUSIC_CD,
        XBOX_GAME,
        PS4_GAME,
        BOOK,
        MISC
    }
    public static Item build(ItemType type, String desc, boolean forRent, boolean forSale, double purchasePrice ){
        switch(type) {
            case CHILDRENS_MOVIE:
                return (Item) new Movie(type, desc, forRent, forSale, CHILDRENS, purchasePrice);
            case NEW_RELEASE_MOVIE:
                return (Item) new Movie(type, desc, forRent, forSale, NEW_RELEASE, purchasePrice);
            case REGULAR_MOVIE:
                return (Item) new Movie(type, desc, forRent, forSale, REGULAR, purchasePrice);
            case XBOX_GAME:
                return (Item) new VideoGame(type, desc, forRent, forSale, XBOX, purchasePrice );
            case PS4_GAME:
                return (Item) new VideoGame(type, desc, forRent, forSale, PS4, purchasePrice );
            case MUSIC_CD:
            case BOOK:
            default:
                return (Item) new DefaultItem(type, desc, false, true, purchasePrice);
        }
    }
    
}
