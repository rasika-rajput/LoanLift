<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tka.entity.User" %> <!-- Adjust the import according to your package structure -->
<!DOCTYPE html>
<html>
<head>
    <title>User Information</title>
    <style>
        /* General page styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        /* Container for user info */
        .user-info-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        /* Header styling */
        h1 {
            font-size: 28px;
            color: #4a90e2;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Styling for paragraphs */
        p {
            font-size: 18px;
            margin: 10px 0;
            color: #555;
        }

        /* Button container */
        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }

        /* Styling for the back button */
        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* Hover effect on button */
        button:hover {
            background-color: #357abd;
        }

        /* Message styling for no user found */
        .no-user-message {
            text-align: center;
            font-size: 20px;
            color: #e74c3c;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<%
    User user = (User) request.getAttribute("user"); 
    if (user != null) 
    { 
%>
    <div class="user-info-container">
        <h1>User Information</h1>
        <p><strong>First Name:</strong> <%= user.getFname() %></p>
        <p><strong>Last Name:</strong> <%= user.getLname() %></p>
        <p><strong>Email:</strong> <%= user.getEmail() %></p>
        <p><strong>Username:</strong> <%= user.getUsername() %></p>
        <p><strong>Mobile:</strong> <%= user.getMobile() %></p>
        <p><strong>Location:</strong> <%= user.getLocation() %></p>
        <p><strong>Status:</strong> <%= user.getStatus() %></p>
    </div>
    
    
<%
    } 
    else 
    {
%>
    <div class="no-user-message">
        <p>No user found.</p>
    </div>
<%
    }
%>

    <div class="action-buttons">
        <button onclick="goBack()">Back to User List</button>
    </div>

    <script>
        function goBack() {
            // Redirect back to the user list page
            window.history.back();
        }
    </script>

</body>
</html>
