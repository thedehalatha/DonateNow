<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>DonateNow — NGO Registration</title>

    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap"
          rel="stylesheet">

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --bg: #0a0a0f;
            --surface: #13131a;
            --surface2: #1c1c26;
            --border: rgba(255,255,255,0.07);
            --accent: #f97316;
            --text: #f1f0ee;
            --muted: #6b6a72;
        }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image:
                linear-gradient(rgba(249,115,22,0.03) 1px, transparent 1px),
                linear-gradient(90deg, rgba(249,115,22,0.03) 1px, transparent 1px);
            background-size: 40px 40px;
            pointer-events: none;
        }

        body::after {
            content: '';
            position: fixed;
            top: -200px;
            left: 50%;
            transform: translateX(-50%);
            width: 600px;
            height: 600px;
            background: radial-gradient(
                circle,
                rgba(249,115,22,0.10) 0%,
                transparent 70%
            );
            pointer-events: none;
        }

        .container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 520px;
        }

        .logo {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
        }

        .logo-icon {
            width: 44px;
            height: 44px;
            background: var(--accent);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .logo-text {
            font-family: 'Syne', sans-serif;
            font-size: 24px;
            font-weight: 800;
        }

        .logo-text span {
            color: var(--accent);
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 35px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }

        h1 {
            font-family: 'Syne', sans-serif;
            font-size: 32px;
            font-weight: 800;
            text-align: center;
            margin-bottom: 8px;
        }

        h1 span {
            color: var(--accent);
        }

        .subtitle {
            text-align: center;
            color: var(--muted);
            font-size: 14px;
            margin-bottom: 28px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-size: 13px;
            color: #b5b4ba;
            margin-bottom: 7px;
        }

        input {
            width: 100%;
            padding: 13px 14px;
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: 10px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            outline: none;
            transition: 0.2s;
        }

        input:focus {
            border-color: rgba(249,115,22,0.5);
            box-shadow: 0 0 0 3px rgba(249,115,22,0.08);
        }

        input::placeholder {
            color: #55545c;
        }

        .register-btn {
            width: 100%;
            margin-top: 8px;
            padding: 13px;
            background: rgba(249,115,22,0.15);
            color: var(--accent);
            border: 1px solid rgba(249,115,22,0.3);
            border-radius: 10px;
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: 0.2s;
        }

        .register-btn:hover {
            background: rgba(249,115,22,0.25);
            transform: translateY(-1px);
        }

        .login-link {
            text-align: center;
            margin-top: 22px;
            color: var(--muted);
            font-size: 13px;
        }

        .login-link a {
            color: var(--accent);
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        @media(max-width: 500px) {
            .card {
                padding: 25px 20px;
            }
        }

    </style>
</head>

<body>

    <div class="container">

        <div class="logo">
            <div class="logo-icon">&#x1F91D;</div>

            <div class="logo-text">
                Donate<span>Now</span>
            </div>
        </div>

        <div class="card">

            <h1>Join <span>DonateNow</span></h1>

            <p class="subtitle">
                Register your NGO and start connecting with people in need.
            </p>

            <form action="ngoRegister" method="post">

                <div class="form-group">
                    <label>NGO Name</label>
                    <input type="text"
                           name="name"
                           placeholder="Enter NGO name"
                           required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email"
                           name="email"
                           placeholder="Enter NGO email"
                           required>
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text"
                           name="phone"
                           placeholder="Enter phone number">
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text"
                           name="address"
                           placeholder="Enter NGO address">
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text"
                           name="username"
                           placeholder="Create username"
                           required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password"
                           name="password"
                           placeholder="Create password"
                           required>
                </div>

                <button type="submit" class="register-btn">
                    Register NGO &rarr;
                </button>

            </form>

            <div class="login-link">
                Already registered?
                <a href="ngoLogin.jsp">Login as NGO</a>
            </div>

        </div>

    </div>

</body>
</html>