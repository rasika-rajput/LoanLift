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
            max-width: 400px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        input[type="text"], input[type="password"], input[type="phone"], select {
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
    </style>
</head>
<body>
<form action="/registeration" method="post">
    <div class="container">
        <h1>Sign Up</h1>
        <p>Please fill in this form to create an account.</p>

        <label for="firstname"><b>First Name</b></label>
        <input type="text" name="fname" placeholder="Enter First Name" required>

        <label for="lastname"><b>Last Name</b></label>
        <input type="text" name="lname" placeholder="Enter Last Name" required>

        <label for="username"><b>Username</b></label>
        <input type="text" name="username" placeholder="Enter Username" required>

        <label for="email"><b>Email</b></label>
        <input type="text" name="email" placeholder="Enter Email" required>

        <label for="psw"><b>Password</b></label>
        <input type="password" name="password" placeholder="Enter Password" required>

        <label for="phone"><b>Phone Number</b></label>
        <input type="text" name="mobile" placeholder="812345678" required>

        <label for="location"><b>Location</b></label>
        <input type="text" name="location" placeholder="Enter Location" required>

        <div class="clearfix">
            <button type="submit" class="btn">Sign Up</button>
        </div>

       
    </div>
</form>
</body>
</html>
