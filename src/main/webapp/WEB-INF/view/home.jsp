<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Homepage</title>
    <style>
    
    button 
    {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    
}

        .btn:hover {
            background-color: #d43d3d;
        }

       .logout-btn
       {
       background-color: red;
    color: white;
       }
       .logout-btn:hover {
    background-color: #d43d3d;
}

/* Apply for Another Loan Button Specific Styles */
.apply-loan-btn {
    background-color: blue; /* Green background */
    color: white;
    margin-top: 20px;
}

.apply-loan-btn:hover {
    background-color: blue; /* Darker green on hover */
}
        h1 {
            color: brown;
            text-align: center;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            margin-top: 30px;
        }
        
        .logout-btn-container{
         display: flex;
            justify-content: right;
            margin-top: 5%;
        }
    </style>
</head>
<body>
    <h1>
        <%= request.getAttribute("successMessage") != null 
            ? request.getAttribute("successMessage") 
            : "Welcome to the homepage!" 
        %>
    </h1>

    <div class="logout-btn-container">
        <!-- Logout Button -->
        <form name = "logout" action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
</div>
<div class="btn-container">
        <!-- Apply for Another Loan Button -->
        <form name = "apply" action="/applyLoan" method="get">
            <button type="submit" class="apply-loan-btn">Apply for Loan</button>
        </form>
    </div>
</body>
</html>
