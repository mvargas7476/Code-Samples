
package ood.homeworkFinal.item;

import ood.homeworkFinal.item.ItemFactory.ItemType;

/**
 * Video Game Item
 * @author Robert Diepenbrock
 * @author Matias Vargas
 */
public class VideoGame extends Item {

    public enum VideoGameTypes {
        XBOX,
        PS4
    }
    private final VideoGameTypes _gameType;
    
    public VideoGame(ItemType type, String desc, boolean Rentable, boolean ForSale, VideoGameTypes gameType, double purchasePrice ) {
        super(type, desc, Rentable, ForSale, purchasePrice);
        _gameType = gameType;
    }
    
}
