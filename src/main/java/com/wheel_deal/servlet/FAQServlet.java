package com.wheel_deal.servlet;

import com.wheel_deal.model.FAQs;
import com.wheel_deal.service.FAQService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

// This servlet handles all the FAQ related requests
@WebServlet("/faqs")
public class FAQServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FAQService faqService;

    // This method runs when the servlet is first loaded
    @Override
    public void init() throws ServletException {
        super.init();
        faqService = new FAQService(); // Create a new service object to work with FAQs
    }

    // This method handles GET requests (like when loading the FAQ page)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
    	
    	String action = request.getParameter("action"); // Get the action from the URL        
        String view = request.getParameter("view");     

        if ("update".equals(action)) {
            // If the action is update, get the FAQ by its ID
            int id = Integer.parseInt(request.getParameter("id"));
            FAQs faqToUpdate = faqService.getFAQ(id); // Get the specific FAQ
            request.setAttribute("faqToUpdate", faqToUpdate); // Pass it to the JSP page
        }

        // Get all FAQs and pass them to the JSP to display
        List<FAQs> faqs = faqService.getAllFAQs();
        request.setAttribute("faqs", faqs);
        if ("user".equals(view)) {
            request.getRequestDispatcher("FAQUser.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("FAQ1.jsp").forward(request, response);
        }              
    }

    // This method handles POST requests (like when submitting a form)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action"); // Get the action from the form

        if ("delete".equals(action)) {
            // If action is delete, try to delete the FAQ by ID
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    boolean isDeleted = faqService.deleteFAQ(id); // Try deleting it

                    if (isDeleted) {
                        response.sendRedirect(request.getContextPath() + "/faqs"); // Redirect to refresh page
                    } else {
                        request.setAttribute("errorMessage", "Failed to delete FAQ.");
                        doGet(request, response); // Show error on the same page
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorMessage", "Invalid FAQ ID.");
                    doGet(request, response); // Show error
                }
            } else {
                request.setAttribute("errorMessage", "Missing FAQ ID.");
                doGet(request, response); // Show error
            }

        } else if ("update".equals(action)) {
            // If action is update, get form data and update the FAQ
            int faqid = Integer.parseInt(request.getParameter("faqid"));
            String question = request.getParameter("question");
            String answer = request.getParameter("answer");

            FAQs faq = new FAQs(); // Create FAQ object
            faq.setFaqid(faqid);
            faq.setQuestion(question);
            faq.setAnswer(answer);

            boolean isUpdated = faqService.updateFAQ(faq); // Try updating it

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/faqs"); // Go back to FAQ list
            } else {
                request.setAttribute("errorMessage", "Failed to update FAQ.");
                doGet(request, response); // Show error
            }

        } else {
            // If no action or any other action, treat it as a new FAQ (Create)
            String question = request.getParameter("question");
            String answer = request.getParameter("answer");

            // Check if both fields are filled
            if (question != null && !question.trim().isEmpty() && answer != null && !answer.trim().isEmpty()) {
                FAQs newFAQ = new FAQs(); // Create new FAQ object
                newFAQ.setQuestion(question);
                newFAQ.setAnswer(answer);

                boolean isCreated = faqService.createFAQ(newFAQ); // Try creating it

                if (isCreated) {
                    response.sendRedirect(request.getContextPath() + "/faqs"); // Go back to FAQ list
                } else {
                    request.setAttribute("errorMessage", "Failed to add new FAQ.");
                    doGet(request, response); // Show error
                }
            } else {
                // If form is incomplete, show an error
                request.setAttribute("errorMessage", "Please enter both question and answer.");
                doGet(request, response);
            }
        }
    }
}
