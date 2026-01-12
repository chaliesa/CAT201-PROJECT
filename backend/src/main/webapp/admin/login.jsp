<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // If already logged in, redirect to dashboard
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn != null && isLoggedIn) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        return;
    }
    
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - KopiCatz</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        }

        /* Login Container */
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #ffe5f0 0%, #fff5f8 50%, #ffe5f0 100%);
            position: relative;
            overflow: hidden;
        }

        /* Decorative Blobs */
        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.7;
            mix-blend-mode: multiply;
        }

        .blob-1 {
            width: 250px;
            height: 250px;
            background: #ffc0cb;
            top: 80px;
            left: 80px;
            animation: blob 7s infinite;
        }

        .blob-2 {
            width: 250px;
            height: 250px;
            background: #ffb6d9;
            top: 160px;
            right: 80px;
            animation: blob 7s infinite 2s;
        }

        .blob-3 {
            width: 250px;
            height: 250px;
            background: #ff8fc7;
            bottom: 80px;
            left: 50%;
            animation: blob 7s infinite 4s;
        }

        @keyframes blob {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(30px, -50px) scale(1.1); }
            66% { transform: translate(-20px, 20px) scale(0.9); }
        }

        /* Login Card */
        .login-card {
            position: relative;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 450px;
            border: 1px solid rgba(255, 182, 217, 0.3);
            z-index: 10;
        }

        /* Header */
        .login-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .logo-circle {
            display: inline-block;
            padding: 16px;
            background: linear-gradient(135deg, #ff8fc7, #ff69b4);
            border-radius: 16px;
            margin-bottom: 16px;
        }

        .lock-icon {
            width: 48px;
            height: 48px;
            color: white;
        }

        .login-title {
            font-size: 28px;
            font-weight: bold;
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 0 0 8px 0;
        }

        .login-subtitle {
            color: #6b7280;
            margin: 0;
            font-size: 14px;
        }

        /* Error Message */
        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px 16px;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            font-weight: 500;
            border: 1px solid #fecaca;
            text-align: center;
        }

        /* Form */
        .login-form {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
        }

        .input-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 8px;
        }

        .input-field {
            width: 100%;
            padding: 12px 16px;
            border-radius: 12px;
            border: 2px solid #ffc0cb;
            background: rgba(255, 255, 255, 0.5);
            font-size: 14px;
            transition: all 0.2s;
            box-sizing: border-box;
        }

        .input-field:focus {
            outline: none;
            border-color: #ff8fc7;
            box-shadow: 0 0 0 4px rgba(255, 143, 199, 0.1);
        }

        .input-field::placeholder {
            color: #9ca3af;
        }

        /* Button */
        .login-button {
            width: 100%;
            background: linear-gradient(135deg, #ff8fc7, #ff69b4);
            color: white;
            font-weight: 600;
            padding: 12px 16px;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.2s;
            box-shadow: 0 10px 15px -3px rgba(255, 105, 180, 0.3);
        }

        .login-button:hover {
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            transform: scale(1.02);
            box-shadow: 0 20px 25px -5px rgba(255, 105, 180, 0.4);
        }

        .login-button:active {
            transform: scale(0.98);
        }

        .login-button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Footer */
        .login-footer {
            text-align: center;
            font-size: 12px;
            color: #9ca3af;
            margin-top: 24px;
            margin-bottom: 0;
        }

        /* Responsive */
        @media (max-width: 640px) {
            .login-card {
                margin: 20px;
                padding: 30px 20px;
            }
            
            .blob {
                width: 150px;
                height: 150px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- Animated blobs -->
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
        <div class="blob blob-3"></div>

        <!-- Login Card -->
        <div class="login-card">
            <div class="login-header">
                <div class="logo-circle">
                    <svg class="lock-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                    </svg>
                </div>
                <h2 class="login-title">KopiCatz Admin</h2>
                <p class="login-subtitle">Welcome back! Please login to continue.</p>
            </div>

            <% if (errorMessage != null) { %>
                <div class="error-message">
                    <%= errorMessage %>
                </div>
            <% } %>

            <form class="login-form" action="<%= request.getContextPath() %>/admin/login" method="post" id="loginForm">
                <div class="input-group">
                    <label class="input-label" for="username">Username</label>
                    <input 
                        type="text" 
                        class="input-field"
                        id="username" 
                        name="username" 
                        placeholder="Enter your username"
                        required 
                        autocomplete="username"
                    >
                </div>

                <div class="input-group">
                    <label class="input-label" for="password">Password</label>
                    <input 
                        type="password" 
                        class="input-field"
                        id="password" 
                        name="password" 
                        placeholder="Enter your password"
                        required
                        autocomplete="current-password"
                    >
                </div>

                <button type="submit" class="login-button" id="loginBtn">
                    Login to Dashboard
                </button>
            </form>

            <p class="login-footer">
                © 2024 KopiCatz. All rights reserved.
            </p>
        </div>
    </div>

    <script>
        // Add Enter key support
        document.getElementById('username').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                document.getElementById('password').focus();
            }
        });

        document.getElementById('password').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                document.getElementById('loginForm').submit();
            }
        });

        // Form submission with loading state
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('loginBtn');
            btn.textContent = 'Logging in...';
            btn.disabled = true;
        });
    </script>
</body>
</html>