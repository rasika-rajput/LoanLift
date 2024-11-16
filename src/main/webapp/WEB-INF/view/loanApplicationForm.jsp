<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loan Application Form</title>
    <style>
        /* Styling for the Loan Application Form heading */
        h1 {
            text-align: center;
            color:  #4CAF50; /* Green color for the heading */
            font-size: 30px;
            margin-bottom: 20px; /* Space below the heading */
            font-weight: bold;
        }

        /* Styling for the loan form table */
        table {
            width: 60%; /* Adjust table width */
            margin: 0 auto; /* Center the table */
            border-collapse: collapse; /* Remove spacing between table cells */
            background-color: #f9f9f9; /* Light background color for table */
            border: 1px solid #ccc; /* Light border around the table */
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* Add subtle shadow */
            padding: 20px; /* Padding inside the table */
        }

        /* Styling for table cells */
        td {
            padding: 10px;
            font-size: 16px; /* Increase font size */
            color: #333; /* Text color */
        }

        /* Styling for input fields and select dropdown */
        input[type="text"], input[type="number"], select, textarea {
            width: 90%; /* Make input fields take full cell width */
            padding: 8px;
            border: 1px solid #ccc; /* Add a border to input fields */
            border-radius: 4px; /* Rounded corners */
            font-size: 16px;
        }

        /* Styling for the submit button */
        input[type="submit"] {
            background-color: #4CAF50; /* Green background */
            color: white; /* White text color */
            padding: 10px 20px; /* Add some padding */
            border: none;
            border-radius: 5px; /* Rounded corners */
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px; /* Space above the button */
            width: 50%; /* Full width button */
        }

        /* Change submit button background on hover */
        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green on hover */
        }

        /* Center the submit button cell */
        td[colspan="2"] {
            text-align: center;
        }
        .message {
            color: red;
           margin-center: 10px;
           text-align: center;
           font-size: 20px;
       
        }
    </style>
    
    <script>
        // Function to validate the form
        function validateForm() {
            let loanAmount = document.forms["loanForm"]["loanAmount"].value;
            let loanType = document.forms["loanForm"]["loanType"].value;
            let loanDuration = document.forms["loanForm"]["loanDuration"].value;
            let panNumber = document.forms["loanForm"]["panNumber"].value;
            let annualIncome = document.forms["loanForm"]["annualIncome"].value;
            let purpose = document.forms["loanForm"]["purpose"].value;
            let username = document.forms["loanForm"]["username"].value; // Get username value

            // Ensure all required fields are filled
            if (!loanAmount || !loanType || !loanDuration || !panNumber || !annualIncome || !purpose) {
                alert("All fields are required except status.");
                return false;
            }

            // Validate that loanAmount and annualIncome are positive numbers
            if (loanAmount <= 0 || isNaN(loanAmount)) {
                alert("Loan Amount must be a positive number.");
                return false;
            }

            if (annualIncome <= 0 || isNaN(annualIncome)) {
                alert("Annual Income must be a positive number.");
                return false;
            }

            // Validate loanDuration is greater than 0
            if (loanDuration <= 0 || isNaN(loanDuration)) {
                alert("Loan Duration must be a valid number greater than 0.");
                return false;
            }

            // Validate PAN number format (for Indian PAN cards)
            let panRegex = /^[A-Z]{5}[0-9]{4}[A-Z]{1}$/;
            if (!panRegex.test(panNumber)) {
                alert("Please enter a valid PAN number.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
 
    <form name="loanForm" action="/loanApplicationForm" method="post" onsubmit="return validateForm()">
        <div class="container">
        <div class="message">
            <% 
                String message = (String) request.getAttribute("errorMsg"); 
                if (message != null) {
                    out.println(message);
                }
            %>
        </div>
        <h1>Loan Application Form</h1>
        <table>
            <tr>
                <td>Username*:</td>
                <td><input type="text" name="username" required /></td>
            </tr>
            <tr>
                <td>Loan Amount*:</td>
                <td><input type="text" name="loanAmount" required /></td>
            </tr>
            <tr>
                <td>Loan Type*:</td>
                <td>
                    <select name="loanType" required>
                        <option value="">--Select Loan Type--</option>
                        <option value="Personal">Personal</option>
                        <option value="Home">Home</option>
                        <option value="Education">Education</option>
                        <option value="Car">Car</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Loan Duration (Months)*:</td>
                <td><input type="number" name="loanDuration" required /></td>
            </tr>
            <tr>
                <td>PAN Number*:</td>
                <td><input type="text" name="panCard" required /></td>
            </tr>
            <tr>
                <td>Annual Income*:</td>
                <td><input type="text" name="annualIncome" required /></td>
            </tr>
            <tr>
                <td>Purpose of Loan*:</td>
                <td><textarea name="purpose" rows="4" cols="50" required></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Submit Loan Application" />
                </td>
            </tr>
        </table>
        </div>
    </form>
</body>
</html>
