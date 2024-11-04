<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e8f5e9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 500px;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            overflow: hidden;
            text-align: center;
            padding: 30px 20px;
        }

        header {
            background-color: #2E7D32;
            color: #fff;
            padding: 20px;
            border-radius: 12px 12px 0 0;
            margin-bottom: 20px;
        }

        .thank-you-message {
            margin-top: 20px;
            font-size: 18px;
            color: #333;
            line-height: 1.5;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 25px;
            background-color: #0288D1;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s, transform 0.2s;
        }

        .back-link:hover {
            background-color: #01579B;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Logout Successful</h1>
        </header>

        <div class="thank-you-message">
            <p>Thank you for your service!</p>
            <p>You have been successfully logged out.</p>
        </div>

        <a href="../index.jsp" class="back-link">Thank You</a>
    </div>
</body>
</html>
