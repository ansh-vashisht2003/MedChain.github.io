<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            text-align: center;
            padding: 20px;
        }

        header {
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 5px;
        }

        .thank-you-message {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
        }

        .back-link {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #008CBA;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .back-link:hover {
            background-color: #005f7f;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Logout</h1>
        </header>

        <div class="thank-you-message">
            <p>Thank you for your service!</p>
            <p>You have successfully logged out.</p>
        </div>

        <a href="index.jsp" class="back-link">Return to Login</a>
    </div>
</body>
</html>
