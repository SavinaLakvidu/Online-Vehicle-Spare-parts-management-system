package com.wheel_deal.servlet;

import com.wheel_deal.model.Item;
import com.wheel_deal.service.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/inventory")
public class ItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        super.init();
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            	
        HttpSession session = request.getSession(false); // false: don't create if it doesn't exist

        if (session == null || session.getAttribute("username") == null) {            
            response.sendRedirect("Login.jsp");
            return;
        }    
        
    	List<Item> items = itemService.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("manage_Inventory.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            try {
                int partId = Integer.parseInt(request.getParameter("partId"));
                String partName = request.getParameter("partName");
                String category = request.getParameter("category");
                String supplierName = request.getParameter("supplierName");
                int quantityInStock = Integer.parseInt(request.getParameter("quantity"));
                double price = Double.parseDouble(request.getParameter("price"));

                Item existingItem = itemService.getItem(partId);
                Date dateAdded = existingItem.getDateAdded();               

                Item item = new Item();
                item.setPartId(partId);
                item.setPartName(partName);
                item.setCategory(category);
                item.setSupplierName(supplierName);
                item.setQuantityInStock(quantityInStock);
                item.setPrice(price);
                item.setDateAdded(dateAdded);               

                boolean success = itemService.updateItem(item);
                if (success) {
                    response.sendRedirect("inventory"); // Refresh page to show updated data
                } else {
                    request.setAttribute("error", "Failed to update item.");
                    doGet(request, response); // Reload with error
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid data for update.");
                doGet(request, response);
            }
        } else if ("addItem".equals(request.getParameter("action"))) {
            
            try {
                String partName = request.getParameter("partName");
                String category = request.getParameter("category");
                String supplierName = request.getParameter("supplierName");
                int quantityInStock = Integer.parseInt(request.getParameter("quantityInStock"));
                double price = Double.parseDouble(request.getParameter("price"));

                if (price < 0) {
                    request.setAttribute("error", "Price cannot be negative.");
                    doGet(request, response);
                    return;
                }
                
                Date dateAdded = new Date(); // Set current date for new items                

                Item item = new Item();
                item.setPartName(partName);
                item.setCategory(category);
                item.setSupplierName(supplierName);
                item.setQuantityInStock(quantityInStock);
                item.setPrice(price);
                item.setDateAdded(dateAdded);                

                boolean success = itemService.createItem(item);
                if (success) {
                    response.sendRedirect("inventory"); // refresh page
                } else {
                    request.setAttribute("error", "Failed to add item.");
                    doGet(request, response); // reload with error
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid data for add.");
                doGet(request, response);
            }
        } else if ("delete".equals(action)) {
            try {
                int partId = Integer.parseInt(request.getParameter("partId"));
                boolean success = itemService.deleteItem(partId);

                if (success) {
                    response.sendRedirect("inventory");
                } else {
                    request.setAttribute("error", "Failed to delete item.");
                    doGet(request, response);
                }
            }
            catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid data for delete.");
                doGet(request, response);
            }
        }
    }
}

