<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Vehicle Spare Parts Management System</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	<link rel="stylesheet" href="Styles/Navigation_Bar_styles.css" />
	<link rel="stylesheet" href="Styles/search_filter.css" />
	<link rel="stylesheet" href="Styles/Inventory_table.css" />
	<link rel="stylesheet" href="Styles/Footer.css" />
	<link rel="stylesheet" href="Styles/EditPartForm.css" />
</head>
<body>
	<header>
		<img src="Styles/LOGO.png" class="logo-img">
    	<nav>
      		<ul>
		        <li><a href="#"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
		        <li><a href="#"><i class="fas fa-cogs"></i> Inventory</a></li>
		        <li><a href="#"><i class="fas fa-truck"></i> Suppliers</a></li>
		        <li><a href="#"><i class="fas fa-file-invoice"></i> Orders</a></li>
		        <li><a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
      		</ul>
    	</nav>

    	<div class="nav-right">
      		<button class="btn-add" onclick="toggleAddForm()"><i class="fas fa-plus" ></i> Add New Part</button>
    	</div>
  	</header>
  			<div class="error-message"></div>
  	        <!-- Form for adding a new part -->
			<div id="add-item-form" class="modal">			
			    <form action="inventory" method="post" class="modal-content">
			        <input type="hidden" name="action" value="addItem" />
			        <h2>Add New Spare Part</h2>
			
			        <label for="partName">Part Name</label>
			        <input type="text" id="partName" name="partName" required>
			
			        <label for="category">Category</label>
			        <input type="text" id="category" name="category" required>
			
			        <label for="quantityInStock">Quantity</label>
			        <input type="number" id="quantityInStock" name="quantityInStock" min="0" required>
			
			        <label for="price">Price ($)</label>
			        <input type="number" id="price" name="price" step="0.01" required>
			
			        <label for="supplierName">Supplier Name</label>
			        <input type="text" id="supplierName" name="supplierName" required>
			
			        <div class="form-actions">
			            <button type="submit" class="btn-submit">Add Part</button>
			            <button type="button" class="btn-cancel" onclick="toggleAddForm()">Cancel</button>
			        </div>
			    </form>
			</div>
			<!-- Form for editing a part -->
			<div id="editPartModal" class="modal hidden">
			    <form method="post" action="inventory" id="editPartForm" class="modal-content">
			        <input type="hidden" name="action" value="update" />
			        <input type="hidden" name="partId" id="editPartId" />
			
			        <label for="editPartName">Part Name</label>
			        <input type="text" name="partName" id="editPartName" required />
			
			        <label for="editCategory">Category</label>
			        <input type="text" name="category" id="editCategory" required />
			
			        <label for="editSupplierName">Supplier Name</label>
			        <input type="text" name="supplierName" id="editSupplierName" required />
			
			        <label for="editQuantity">Quantity</label>
			        <input type="number" name="quantity" id="editQuantity" required />
			
			        <label for="editPrice">Price</label>
			        <input type="number" step="0.01" name="price" id="editPrice" required />
			
			        <div class="form-actions">
			            <button type="submit" class="btn-submit">Update</button>
			            <button type="button" class="btn-cancel" onclick="closeEditModal()">Cancel</button>
			        </div>
			    </form>
			</div>
			<!-- Form for viewing details of a new part -->
			<div id="viewModal" class="modal">
				<form class="modal-content" onsubmit="return false;">
				    <h2>Part Details</h2>
				
				    <label>Part ID</label>
				    <input type="text" id="view-partId" readonly>
				
				    <label>Part Name</label>
				    <input type="text" id="view-partName" readonly>
				
				    <label>Category</label>
				    <input type="text" id="view-category" readonly>
				
				    <label>Supplier Name</label>
				    <input type="text" id="view-supplier" readonly>
				
				    <label>Quantity in Stock</label>
				    <input type="text" id="view-quantity" readonly>
				
				    <label>Price</label>
				    <input type="text" id="view-price" readonly>
				
				    <div style="text-align: center;">
				    	<button type="button" class="btn-cancel" onclick="closeViewModal()">Close</button>
				    </div>
				</form>
			</div>
  	    <section class="search-panel">
    		<div class="search-box">
      			<input type="text" id="search-input" placeholder="Search by part name, ID or category..." />
      			<button><i class="fas fa-search"></i></button>
	    	</div>
	  	</section>
	  	<section class="inventory-section">
    		<h2>Inventory List</h2>
    		<table class="inventory-table">
      			<thead>
        			<tr>
				    	<th>Part ID</th>
				        <th>Part Name</th>
				        <th>Category</th>
				        <th>Vehicle Model</th>
				        <th>Quantity</th>
				        <th>Price</th>
				        <th>Status</th>
				        <th>Actions</th>
        			</tr>
      			</thead>
      			<tbody>
				<c:forEach var="item" items="${items}">
				    <tr
				        data-id="${item.partId}" 
        				data-name="${item.partName}" 
				        data-category="${item.category}"
				        data-supplier="${item.supplierName}" 
				        data-quantity="${item.quantityInStock}" 
				        data-price="${item.price}">
				        <td>${item.partId}</td>
				        <td>${item.partName}</td>
				        <td>${item.category}</td>
				        <td>${item.supplierName}</td>
				        <td>${item.quantityInStock}</td>
				        <td>$${item.price}</td>
				        <td>
				            <span class="status ${item.quantityInStock > 0 ? 'in-stock' : 'out-of-stock'}">
				                ${item.quantityInStock > 0 ? 'In Stock' : 'Out of Stock'}
				            </span>
				        </td>
				        <td>
				            <button class="action-btn edit" title="Edit Part" onclick="openEditModal(this)"><i class="fas fa-edit"></i></button>
				            <button class="action-btn delete" title="Delete Part" onclick="confirmDelete(${item.partId})"><i class="fas fa-trash-alt"></i></button>
				            <button class="action-btn view" title="View Part Details" onclick="openViewModal(this.closest('tr'))"><i class="fas fa-eye"></i></button>
				        </td>
				    </tr>
				</c:forEach>
                
      			</tbody>
            </table> 
  		</section>
  		    <div class="modal" id="deleteModal">
				<div class="modal-content">
				    <h2>Are you sure?</h2>
				    <p>This action cannot be undone.</p>
				    <form id="deleteForm" method="post" action="inventory">
				      <input type="hidden" name="action" value="delete" />
				      <input type="hidden" name="partId" id="deletePartId" />
				      <div class="form-actions">
				        <button type="submit" class="btn-submit">Yes, Delete</button>
				        <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
				      </div>
				    </form>
				</div>
			</div>  		
			<hr>
		<footer class="f2">			
	    	<div class="f2container">
	    		<div class="footer-text">
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
				</div>           
			<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3960.798467277478!2d79.96807357565235!3d6.914682800690499!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae256db1a6771c5%3A0x2c63e344ab9a7536!2sSri%20Lanka%20Institute%20of%20Information%20Technology!5e0!3m2!1sen!2slk!4v1746612820302!5m2!1sen!2slk" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"> </iframe>
			</div>
		</footer>
	
		<script>
		    function toggleAddForm() {
		        const modal = document.getElementById("add-item-form");
		        modal.style.display = (modal.style.display === "flex") ? "none" : "flex";
		    }
		
		    window.onclick = function(event) {
		        const modal = document.getElementById("add-item-form");
		        if (event.target === modal) {
		            modal.style.display = "none";
		        }
		    };
		</script>
		<script>
			const searchInput = document.getElementById('search-input');
			const rows = Array.from(document.querySelectorAll('.inventory-table tbody tr'));
		
		    function filterSearch() {
		    	const query = searchInput.value.toLowerCase();
		
			    rows.forEach(row => {
			        const name = row.dataset.name.toLowerCase();
			        const id = row.dataset.id.toLowerCase();
			        const cat = row.dataset.category.toLowerCase();
			
			        const matchesQuery = name.includes(query) || id.includes(query) || cat.includes(query);
			        row.style.display = matchesQuery ? '' : 'none';
			    });
		    }
		
		  searchInput.addEventListener('input', filterSearch);
		</script>
		<script>
			function openEditModal(button) {
			    const row = button.closest('tr');
			    document.getElementById('editPartId').value = row.dataset.id;
			    document.getElementById('editPartName').value = row.dataset.name;
			    document.getElementById('editCategory').value = row.dataset.category;
			    document.getElementById('editSupplierName').value = row.dataset.supplier;
			    document.getElementById('editQuantity').value = row.dataset.quantity;
			    document.getElementById('editPrice').value = row.dataset.price;
	
			    // Show modal
			    document.getElementById('editPartModal').classList.remove('hidden');
			    document.getElementById('editPartModal').style.display = 'flex';
			}
	
			function closeEditModal() {
			    document.getElementById('editPartModal').classList.add('hidden');
			    document.getElementById('editPartModal').style.display = 'none';
			}
	    </script>
	    <script>
		    function confirmDelete(partId) {
		        document.getElementById('deletePartId').value = partId;
		        document.getElementById('deleteModal').style.display = 'flex';
		    }
	
		    function closeModal() {
		        document.getElementById('deleteModal').style.display = 'none';
		    }
	    </script>
		<script>
			function openViewModal(row) {
				document.getElementById('view-partId').value = row.dataset.id;
				document.getElementById('view-partName').value = row.dataset.name;
				document.getElementById('view-category').value = row.dataset.category;
				document.getElementById('view-supplier').value = row.dataset.supplier;
				document.getElementById('view-quantity').value = row.dataset.quantity;
				document.getElementById('view-price').value = row.dataset.price;
				document.getElementById('viewModal').style.display = 'flex';
			}

			function closeViewModal() {
				document.getElementById('viewModal').style.display = 'none';
			}
		</script>
		<script>
			document.querySelector('.modal-content').addEventListener('submit', function(event) {
			    const priceInput = document.getElementById('price');
			    const price = parseFloat(priceInput.value);
			    const errorBox = document.querySelector('.error-message');
			    const modal = document.getElementById('add-item-form');
	
			    if (price < 0) {
			        event.preventDefault();			        
			        modal.style.display = 'none';			        
			        errorBox.textContent = '❗ Price cannot be negative. Please enter a valid amount.';
			        errorBox.style.display = 'block';			        
			        setTimeout(() => {
			            errorBox.style.display = 'none';
			        }, 5000);
			    }
			});
		</script>
</body>
</html>