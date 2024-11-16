<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - User Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f9;
        }

        .container {
            width: 90%;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .search-box {
            float: right;
            margin-bottom: 15px;
        }

        .search-box input {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .search-box1 {
            float: right;
            margin-bottom: 15px;
        }

        .search-box1 input {
            padding: 8px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        .action-btns button {
            padding: 8px 12px;
            margin: 0 5px;
            border: none;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-view {
            background-color: brown;
        }

        .btn-view:hover {
            background-color: #brown;
        }
        
        .btn-edit {
            background-color: #007bff;
        }

        .btn-edit:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }
        
        .btn-reject {
            background-color: #dc3545;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }

        .btn-deactivate {
            background-color: orange;
        }

        .btn-deactivate:hover {
            background-color: #e0a800;
        }

        .btn-activate {
            background-color: #28a745;
        }

        .btn-activate:hover {
            background-color: #218838;
        }
        
        .btn-approve {
            background-color: #28a745;
        }

        .btn-approve:hover {
            background-color: #218838;
        }

        .btn-add {
            background-color: #28a745;
            padding: 10px 20px;
            color: white;
            border: none;
            cursor: pointer;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }

        .btn-add:hover {
            background-color: #218838;
        }

        .popup {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            border: 1px solid #ddd;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .popup-buttons {
            text-align: center;
        }

        .popup-buttons button {
            padding: 10px 15px;
            margin: 5px;
            cursor: pointer;
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            z-index: 999;
        }

        .container h1 {
            margin-bottom: 15px;
        }

       /*  td:first-child {
            cursor: pointer;
            color: #007bff;
        }

        td:first-child:hover {
            text-decoration: underline;
        } */
    </style>
</head>
<body>

<div class="container">
    <h1>User Management</h1>
    
    <div class="search-box">
        <input type="text" placeholder="Search users..." id="searchInput" onkeyup="searchFunction()">
    </div>
    <table id="userTable">
        <thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
       <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.fname}</td>
            <td>${user.lname}</td>
            <td>${user.email}</td>
            <td>${user.status}</td>
            <td class="action-btns">
                <button class="btn-view" onclick="viewUser('${user.email}')">View</button>
                <button class="btn-edit" onclick="confirmEdit()">Edit</button>
                <c:choose>
    <c:when test="${user.status eq 'Active'}">
        <button class="btn-deactivate" onclick="confirmChangeStatus('deactivate', '${user.email}')">Deactivate</button>
    </c:when>
    <c:otherwise>
        <button class="btn-activate" onclick="confirmChangeStatus('activate', '${user.email}')">Activate</button>
    </c:otherwise>
</c:choose>
                <button class="btn-delete" onclick="confirmDelete('${user.email}')">Delete</button>
            </td>
        </tr>
    </c:forEach>
</tbody>

    </table>
</div>

<!-- Overlay and Popup for Confirmations -->
<div class="overlay" id="overlay"></div>

<div class="popup" id="deletePopup">
    <p>Are you sure you want to delete this user?</p>
    <div class="popup-buttons">
        <button onclick="deleteUser()">Confirm</button>
        <button onclick="closePopup()">Cancel</button>
    </div>
</div>

<div class="popup" id="editPopup">
    <p>Are you sure you want to edit this user?</p>
    <div class="popup-buttons">
        <button onclick="editUser()">Confirm</button>
        <button onclick="closePopup()">Cancel</button>
    </div>
</div>

<div class="popup" id="statusPopup">
    <p>Are you sure you want to change the status of this user?</p>
    <div class="popup-buttons">
        <button onclick="changeUserStatus()">Confirm</button>
        <button onclick="closePopup()">Cancel</button>
    </div>
</div>

<div class="popup" id="approvePopup">
    <p>Are you sure you want to approve this loan?</p>
    <div class="popup-buttons">
        <button onclick="approveLoan()">Confirm</button>
        <button onclick="closePopup()">Cancel</button>
    </div>
</div>

<div class="popup" id="rejectPopup">
    <p>Are you sure you want to reject this loan?</p>
    <div class="popup-buttons">
        <button onclick="rejectLoan()">Confirm</button>
        <button onclick="closePopup()">Cancel</button>
    </div>
</div>

<div class="container">
    <h1>Loan Review Dashboard</h1>
    
    <div class="search-box1">
        <input type="text" placeholder="Search loan applications..." id="searchInput1" onkeyup="searchLoanFunction()">
    </div>
    <table id="loanTable">
        <thead>
            <tr>
                <th>Loan ID</th>
                <th>User Name</th>
                <th>Loan Amount</th>
                <th>Loan Type</th>
                <th>Application Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
       <tbody>
    <c:forEach var="loanApps" items="${loanApps}">
        <tr>
            <td>${loanApps.loanId}</td>
           <td>${loanApps.user.fname} ${loanApps.user.lname}</td> 
                    <td>${loanApps.loanAmount}</td> 
                    <td>${loanApps.loanType}</td> 
                    <td>${loanApps.applicationDate}</td> 
                    <td>${loanApps.status}</td>
            <td class="action-btns">
                <button class="btn-view" onclick="viewLoanApps('${loanApps.loanId}')">View</button>
                
                <c:choose>
           <c:when test="${loanApps.status eq 'Pending'}">
        <button class="btn-approve" onclick="confirmApprove('${loanApps.loanId}')">Approve</button>
   
        <button class="btn-reject" onclick="confirmReject('${loanApps.loanId}')">Reject</button>
    </c:when>
    </c:choose>
            </td>
        </tr>
    </c:forEach>
</tbody>

    </table>
</div>


<script>
    let currentAction = null;

    function searchFunction() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toLowerCase();
        table = document.getElementById("userTable");
        tr = table.getElementsByTagName("tr");

        for (i = 1; i < tr.length; i++) {
            tr[i].style.display = "none";
            for (var j = 0; j < 6; j++) {
                td = tr[i].getElementsByTagName("td")[j];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        break;
                    }
                }
            }
        }
    }
    
    let currentAction1 = null;

     function searchLoanFunction() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput1");
        filter = input.value.toLowerCase();
        table = document.getElementById("loanTable");
        tr = table.getElementsByTagName("tr");

        for (i = 1; i < tr.length; i++) {
            tr[i].style.display = "none";
            for (var j = 0; j < 6; j++) {
                td = tr[i].getElementsByTagName("td")[j];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        break;
                    }
                }
            }
        }
    } 
    
    let currentEmailToDelete = null;

    function confirmDelete(email) {
        currentAction = 'delete';
        currentEmailToDelete = email;
        document.getElementById("overlay").style.display = "block";
        document.getElementById("deletePopup").style.display = "block";
    }
    
    let currentIdToApproveLoan = null;
    
    function confirmApprove(loanId) {
        currentAction = 'approve';
        currentIdToApproveLoan = loanId;
        document.getElementById("overlay").style.display = "block";
        document.getElementById("approvePopup").style.display = "block";
    }
    
    let currentIdToRejectLoan = null;
    
    function confirmReject(loanId) {
        currentAction = 'reject';
        currentIdToRejectLoan = loanId;
        document.getElementById("overlay").style.display = "block";
        document.getElementById("rejectPopup").style.display = "block";
    }

    function confirmEdit() {
        currentAction = 'edit';
        document.getElementById("overlay").style.display = "block";
        document.getElementById("editPopup").style.display = "block";
    }
    let currentEmailToUpdateStatus = null;
    let currentStatusAction = null;
    
    function confirmChangeStatus(action, email) {
    	currentEmailToUpdateStatus = email;
        currentStatusAction = action;
        document.getElementById("overlay").style.display = "block";
        document.getElementById("statusPopup").style.display = "block";
    }

    function closePopup() {
        document.getElementById("overlay").style.display = "none";
        document.getElementById("deletePopup").style.display = "none";
        document.getElementById("editPopup").style.display = "none";
        document.getElementById("statusPopup").style.display = "none";
        document.getElementById("approvePopup").style.display = "none";
        document.getElementById("rejectPopup").style.display = "none";

    }

    function deleteUser() {
        alert("User deleted successfully");
        closePopup();
        // Implement actual delete logic via Spring MVC here
        
            // Assuming you want to delete a user by their email
            const email = currentEmailToDelete;

            // Send a DELETE request to the server
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/delete-user", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("User deleted successfully");
                    closePopup();
                    // Optionally, reload or update the table after deletion
                    location.reload(); // Or remove the row dynamically without refreshing
                }
            };

            xhr.send("email=" + encodeURIComponent(email));
        

    }
    
    function approveLoan() {
        alert("Loan Approved");
        closePopup();
        // Implement actual delete logic via Spring MVC here
        
            // Assuming you want to delete a user by their email
            const loanId = currentIdToApproveLoan;

            // Send a DELETE request to the server
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/approve-loan", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("Loan Approved");
                    closePopup();
                    // Optionally, reload or update the table after deletion
                    location.reload(); // Or remove the row dynamically without refreshing
                }
            };

            xhr.send("loanId=" + encodeURIComponent(loanId));
        

    }

    function rejectLoan() {
        alert("Loan Rejected");
        closePopup();
        // Implement actual delete logic via Spring MVC here
        
            // Assuming you want to delete a user by their email
            const loanId = currentIdToRejectLoan;

            // Send a DELETE request to the server
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/reject-loan", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("Loan Rejected");
                    closePopup();
                    // Optionally, reload or update the table after deletion
                    location.reload(); // Or remove the row dynamically without refreshing
                }
            };

            xhr.send("loanId=" + encodeURIComponent(loanId));
        

    }
    
    function editUser() {
        alert("User edited successfully");
        closePopup();
        // Implement actual edit logic via Spring MVC here
    }

    function changeUserStatus() {
        if (currentAction === 'activate') {
            alert("User activated successfully");
        } else {
            alert("User deactivated successfully");
        }
        closePopup();
        // Implement actual status change logic via Spring MVC here
        const email = currentEmailToUpdateStatus;
        const action = currentStatusAction;

        // Send a POST request to the server to update the status
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "/update-user-status", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert("User status updated successfully");
                closePopup();
                // Optionally, reload or update the table after status change
                location.reload(); // Or update the row dynamically without refreshing
            }
        };

        xhr.send("email=" + encodeURIComponent(email) + "&action=" + encodeURIComponent(action));

    }

   function viewUser(email) {
        // Redirect to the view-user-info.jsp page with the user ID as a parameter
	    window.location.href = `/view-user-info?email=` + encodeURIComponent(email);
    }
   
   function viewLoanApps(loanId) {
       // Redirect to the view-user-info.jsp page with the user ID as a parameter
	    window.location.href = `/view-loan-info?loanId=` + encodeURIComponent(loanId);
   }
  
   
</script>

</body>
</html>
