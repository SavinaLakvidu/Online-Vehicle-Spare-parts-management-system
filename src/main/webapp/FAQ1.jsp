<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  <%-- Import JSTL core tag library for loops, conditions etc. --%>
<%@ page session="true" %>
<%
    String username = (String) session.getAttribute("username");

    // Block access if no one is logged in
    if (username == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<%
    username = (String) session.getAttribute("username");
    if (username != null) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN CSA</title>
    <link rel="stylesheet" href="FAQ1Styles/FAQ 1.css"> <%-- Link to CSS file --%>
    
    <!-- JavaScript for toggling the Add and Update FAQ form visibility -->
    <script>
        function toggleAddFAQFormTop() {
            // Show or hide the "Add FAQ" form
            var form = document.getElementById('addFAQFormTop');
            form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
        }

        function toggleUpdateFAQForm(faqid, question, answer) {
            // Show or hide the "Update FAQ" form and fill it with selected FAQ data
            var form = document.getElementById('updateFAQForm');
            var questionInput = document.getElementById('update-question');
            var answerInput = document.getElementById('update-answer');
            var faqidInput = document.getElementById('update-faqid');

            if (faqid && question && answer) {
                questionInput.value = question; // Fill in question
                answerInput.value = answer;     // Fill in answer
                faqidInput.value = faqid;       // Fill in FAQ ID
            }

            form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
        }
    </script>
</head>
<body>

<!-- Add FAQ Form (Popup) -->
<div class="add-faq-form-top" id="addFAQFormTop" style="display: none;">
    <div class="add-faq-form-content">
        <h3>Add New FAQ</h3>
        <button type="button" class="close-button" onclick="toggleAddFAQFormTop()">×</button>
        <form action="faqs" method="post">  <%-- Form to submit new FAQ to server --%>
            <label for="question">Question:</label>
            <input type="text" class="question" name="question" required><br><br>

            <label for="answer">Answer:</label>
            <textarea class="answer" name="answer" rows="5" required></textarea><br><br>

            <button type="submit">Submit FAQ</button> <%-- Submit button --%>
            <button type="button" onclick="toggleAddFAQFormTop()">Cancel</button> <%-- Cancel and close form --%>
        </form>
    </div>
</div>

<!-- Update FAQ Form (Popup - Blue Style) -->
<div class="update-faq-form-top" id="updateFAQForm" style="display: none;">
    <div class="update-faq-form-content">
        <h3>Update FAQ</h3>
        <button type="button" class="close-button" onclick="toggleUpdateFAQForm()">x</button>
        <form action="faqs" method="post">  <%-- Form to send updated FAQ data --%>
            <input type="hidden" name="action" value="update"> <%-- Hidden input to tell server this is an update --%>
            <input type="hidden" name="faqid" id="update-faqid"> <%-- Hidden field to store the FAQ ID --%>

            <label for="update-question">Question:</label>
            <input type="text" name="question" id="update-question" required><br><br>

            <label for="update-answer">Answer:</label>
            <textarea name="answer" id="update-answer" rows="5" required></textarea><br><br>
	
            <div class="ubuttons">
            <button type="submit" class="update-submit-button">Update</button> <%-- Submit updated FAQ --%>
            <button type="button" onclick="toggleUpdateFAQForm()">Cancel</button> <%-- Cancel and close form --%>
            </div>
        </form>
    </div>
</div>

<header>
    <div class="container">
        <img src="FAQ1Styles/LOGO.png"> <%-- Company logo --%>
        <nav>
            <ul>
                <%-- Navigation links --%>
                <li><a href="Home.jsp">Home</a></li>
                <li><a href="#">Spare Parts</a></li>
                <li><a href="#">Contact Us</a></li>
                <li><a href="faqs">FAQ</a></li>
                <li><a href="LogoutServlet"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
				<% } else { %>
    			<li><a href="Login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
				<% } %>
            </ul>
        </nav>
    </div>
</header>

<div class="profile">
    <div class="PP">
        <img src="FAQ1Styles/PP.jpg" class="img"> <%-- Profile picture --%>
    </div>
    <div class="Prof">
        <%-- Profile information --%>
        <ul> 
            <li class="Name"> Chethiya Herath </li>
            <li> Customer Service Agent </li>
            <li> Suche003</li>
            <li>it23552456@my.sliit.lk</li>
        </ul>
    </div>
</div>

<section class="faq-section">
    <h2>Frequently Asked Questions</h2>
    <div class="faq-list" id="faq-container">
        <%-- Loop through the list of FAQs and show them one by one --%>
        <c:forEach var="faq" items="${faqs}">
            <div class="faq-item">
                <h3 class="faq-question">${faq.question}</h3>
                <p class="faq-answer">${faq.answer}</p>
                
			    <div class="dubuttons">
			
                <!-- Delete button -->
                <form action="faqs" method="post" onsubmit="return confirm('Are you sure you want to delete this FAQ?');">
                    <input type="hidden" name="action" value="delete"> <%-- Set action to delete --%>
                    <input type="hidden" name="id" value="${faq.faqid}"> <%-- Pass the FAQ ID --%>
                    <button type="submit" class="delete-faq-button">Delete</button>
                </form>

                <!-- Update button -->
                <button type="button"
                        class="update-faq-button"
                        onclick="toggleUpdateFAQForm(${faq.faqid}, '${faq.question.replace("'", "\\'")}', '${faq.answer.replace("'", "\\'")}')">
                    Update
                </button> <%-- Call JS function to show update form with data --%>
                
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="faq-controls">
        <button class="add-faq-button" onclick="toggleAddFAQFormTop()">ADD NEW FAQ</button> <%-- Button to show Add FAQ form --%>
    </div>
</section>

<hr>

<footer class="f2">

        <div class="f2container">
            <ul>
                <li>Wheel Deal (Pvt) Ltd, </li>
                <li> New Kandy Rd,  </li> 
                <li>Malabe, </li>
                <li>Colombo District, </li>
                <li> Sri Lanka. </li>
            </ul>
            <ul>
                <li>+94 112 123 4123 - Head Office</li>
                <li>+94 112 123 4124 - General Inquiries</li>
                <li>+94 112 123 4125 - Supplier Inquiries</li>
                <li>info@wheeldeal.com</li>
            </ul>
            

             <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798467277478!2d79.96807357565235!3d6.914682800690499!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae256db1a6771c5%3A0x2c63e344ab9a7536!2sSri%20Lanka%20Institute%20of%20Information%20Technology!5e0!3m2!1sen!2slk!4v1746612820302!5m2!1sen!2slk" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"> </iframe>

        </div>

</footer>

</body>
</html>
