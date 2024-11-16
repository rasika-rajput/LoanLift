<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tka.entity.LoanApplication" %> <!-- Adjust the import according to your package structure -->
<!DOCTYPE html>
<html>
<head>
    <title>Loan Application Details</title>
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
        .loan-info-container {
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
        .no-loan-message {
            text-align: center;
            font-size: 20px;
            color: #e74c3c;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<%
    LoanApplication loanApp = (LoanApplication) request.getAttribute("loanApp"); 
    if (loanApp != null) 
    { 
%>
    <div class="loan-info-container">
        <h1>Loan Application Details</h1>
        <p><strong>User Name:</strong> <%= loanApp.user.getFname() +" " +loanApp.user.getLname() %></p>
        <p><strong>User Email:</strong> <%= loanApp.user.getEmail() %></p>
        <p><strong>User Mobile:</strong> <%= loanApp.user.getMobile() %></p>
        <p><strong>Loan Amount:</strong> <%= loanApp.getLoanAmount() %></p>
        <p><strong>Loan Type:</strong> <%= loanApp.getLoanType() %></p>
        <p><strong>Loan Duration:</strong> <%= loanApp.getLoanDuration() %></p>
        <p><strong>Annual Income:</strong> <%= loanApp.getAnnualIncome() %></p>
        <p><strong>Purpose:</strong> <%= loanApp.getPurpose() %></p>
        <p><strong>Application Date:</strong> <%= loanApp.getApplicationDate() %></p>
        <p><strong>Status:</strong> <%= loanApp.getStatus() %></p>
    </div>
    
    
<%
    } 
    else 
    {
%>
    <div class="no-loan-message">
        <p>No loan application found.</p>
    </div>
<%
    }
%>

    <div class="action-buttons">
        <button onclick="goBack()">Back to Loan Applications List</button>
    </div>

    <script>
        function goBack() {
            // Redirect back to the user list page
            window.history.back();
        }
    </script>

</body>
</html>
