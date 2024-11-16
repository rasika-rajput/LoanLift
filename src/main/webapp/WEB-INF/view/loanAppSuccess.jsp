<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loan Application Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }
        .message-container {
            text-align: center;
            background-color: white;
            padding: 40px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            max-width: 500px;
            width: 90%;
        }
        h1 {
            color: #4CAF50;
            font-size: 36px;
            margin-bottom: 20px;
        }
        h3 {
            color: #333;
            font-size: 24px;
            margin-top: 30px;
            margin-bottom: 10px;
        }
        p {
            font-size: 18px;
            color: #555;
            margin: 10px 0;
        }
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="message-container">
        <h1>Loan Application Success!</h1>
        <p>Your loan application has been submitted successfully.</p>

        <!-- Display Interest Rate Calculation Result -->
        <br>
        <p>For PAN <strong>${panCard}</strong>, with a CIBIL score of <strong>${cibilScore}</strong>, the interest rate of <strong>${loanType} Loan</strong> is <strong>${interestRate}%</strong> .</p>
       

        <!-- Button to apply for another loan -->
        <a href="/applyLoan" class="back-btn">Apply for Another Loan</a>
    </div>
</body>
</html>
