<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>Your CIBIL Score</title>
    
    <style>
  h1 {
            color: brown;
        }

        .btn-container {
            display: flex;
            margin-top: 30px;
        }
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
        .apply-loan-btn {
    background-color: blue; /* Green background */
    color: white;
    margin-top: 20px;
}

.apply-loan-btn:hover {
    background-color: blue; /* Darker green on hover */
}
</style>

</head>
<body>
    <h1>Your CIBIL Score</h1>
    <p>Your CIBIL score is: <strong>${cibilScore}</strong></p>
    <br>
    <br>
    <div class="btn-container">
        <!-- Apply for Another Loan Button -->
        <form name = "apply" action="/applyLoan" method="get">
            <button type="submit" class="apply-loan-btn">Apply for Loan</button>
        </form>
    </div>
</body>
</html>

