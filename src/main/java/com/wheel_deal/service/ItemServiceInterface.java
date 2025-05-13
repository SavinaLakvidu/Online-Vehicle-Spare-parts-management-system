package com.wheel_deal.service;

import com.wheel_deal.model.Item;
import java.util.List;

public interface ItemServiceInterface {
	
    List<Item> getAllItems();
    Item getItem(int partId);
    boolean createItem(Item item);
    boolean updateItem(Item item);
    boolean deleteItem(int partId);
    
}
