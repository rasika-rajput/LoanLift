<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>User Registration Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        input[type="text"], input[type="password"], input[type="phone"], input[type="email"] , select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            transition: 0.3s ease-in-out;
        }
        input[type="text"]:focus, input[type="password"]:focus, input[type="phone"]:focus, select:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.3);
        }
        .clearfix button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .clearfix button:hover {
            background-color: #0056b3;
        }
        .login-link {
            text-align: center;
            margin-top: 10px;
        }
        a {
            color: dodgerblue;
        }
        a:hover {
            color: darkblue;
            text-decoration: underline;
        }
        
        .error {
            color: red;
        }
         .message {
            color: red;
           margin-top: 10px;
        }
    </style>
</head>
<body>
<form action="/check-CIBIL-score" method="post" onsubmit="return validateForm()">
    <div class="container">
     <div class="message">
            <% 
                String message = (String) request.getAttribute("panInvalid"); 
                if (message != null) {
                    out.println(message);
                }
            %>
        </div>
       <h2>Check CIBIL Score</h2>
        <label for="firstname"><b>First Name</b></label>
        <input type="text" name="fname" id="fname" placeholder="Enter First Name" required>
        <span class="error" id="fnameError"></span><br>

        <label for="lastname"><b>Last Name</b></label>
        <input type="text" name="lname" id="lname" placeholder="Enter Last Name" required>
        <span class="error" id="lnameError"></span><br>

        <label for="phone"><b>Phone Number</b></label>
        <input type="text" name="mobile" id="mobile" placeholder="8123456789" required>
        <span class="error" id="mobileError"></span><br>
        
        <label for="email"><b>Email</b></label>
        <input type="email" name="email" id="email" placeholder="Enter Email" required>
        <span class="error" id="emailError"></span><br>

        <label for="location"><b>Location</b></label>
        <input type="text" name="location" id="location" placeholder="Enter Location" required><br>

        <label for="panCard"><b>PAN Card Number</b></label>
        <input type="text" name="panCard" id="panCard" placeholder="Enter PAN Card Number" required>
        <span class="error" id="panCardError"></span><br>
        
        <div class="clearfix">
            <button type="submit" class="btn">Check CIBIL Score</button>
        </div>
        </div>
    </form>

    <script>
        function validateForm() {
            let isValid = true;

            // Clear previous error messages
            document.getElementById('fnameError').innerText = '';
            document.getElementById('lnameError').innerText = '';
            document.getElementById('mobileError').innerText = '';
            document.getElementById('emailError').innerText = '';
            document.getElementById('panCardError').innerText = '';

            // Validate First Name: Only letters
            const fname = document.getElementById('fname').value;
            if (!/^[A-Za-z]+$/.test(fname)) {
                document.getElementById('fnameError').innerText = 'First name must contain only letters.';
                isValid = false;
            }

            // Validate Last Name: Only letters
            const lname = document.getElementById('lname').value;
            if (!/^[A-Za-z]+$/.test(lname)) {
                document.getElementById('lnameError').innerText = 'Last name must contain only letters.';
                isValid = false;
            }

            // Validate Mobile: Exactly 10 digits
            const mobile = document.getElementById('mobile').value;
            if (!/^\d{10}$/.test(mobile)) {
                document.getElementById('mobileError').innerText = 'Mobile number must be 10 digits.';
                isValid = false;
            }

            // Validate Email: Must be in valid format
            const email = document.getElementById('email').value;
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                document.getElementById('emailError').innerText = 'Please enter a valid email address.';
                isValid = false;
            }

            // Validate PAN Card: Format ABCDE1234F
            const panCard = document.getElementById('panCard').value;
            if (!/^[A-Z]{5}[0-9]{4}[A-Z]{1}$/.test(panCard)) {
                document.getElementById('panCardError').innerText = 'PAN card format is invalid (ABCDE1234F).';
                isValid = false;
            }

            return isValid;
        }
    </script>

</body>
</html>