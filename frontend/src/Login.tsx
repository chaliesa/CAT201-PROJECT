import React, { useState } from 'react';

const Login = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');

    const handleLogin = async () => {
        if (username === 'admin' && password === '123') {
            localStorage.setItem('isLoggedIn', 'true');
            alert('Login Successful (Local Mode)');
            window.location.href = '/admin';
            return;
        }

        try {
            const response = await fetch('http://localhost:8080/backend/LoginServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `username=${username}&password=${password}`
            });
            const data = await response.json();
            if (data.status === 'success') {
                localStorage.setItem('isLoggedIn', 'true');
                window.location.href = '/admin';
            }
        } catch (error) {
            console.log("Java Backend not reached, using local credentials.");
        }
    };

    return (
        <div style={{
            minHeight: '100vh',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            background: 'linear-gradient(135deg, #ffe5f0 0%, #fff5f8 50%, #ffe5f0 100%)',
            position: 'relative',
            overflow: 'hidden'
        }}>
            {/* Animated blobs */}
            <div style={{
                position: 'absolute',
                width: '250px',
                height: '250px',
                background: '#ffc0cb',
                borderRadius: '50%',
                top: '80px',
                left: '80px',
                filter: 'blur(60px)',
                opacity: 0.7
            }}></div>
            <div style={{
                position: 'absolute',
                width: '250px',
                height: '250px',
                background: '#ffb6d9',
                borderRadius: '50%',
                top: '160px',
                right: '80px',
                filter: 'blur(60px)',
                opacity: 0.7
            }}></div>

            {/* Login Card */}
            <div style={{
                position: 'relative',
                background: 'rgba(255, 255, 255, 0.8)',
                backdropFilter: 'blur(10px)',
                padding: '40px',
                borderRadius: '24px',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
                width: '100%',
                maxWidth: '450px',
                border: '1px solid rgba(255, 182, 217, 0.3)',
                zIndex: 10
            }}>
                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '32px' }}>
                    <div style={{
                        display: 'inline-block',
                        padding: '16px',
                        background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
                        borderRadius: '16px',
                        marginBottom: '16px'
                    }}>
                        <svg style={{ width: '40px', height: '40px', color: 'white' }} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                        </svg>
                    </div>
                    <h2 style={{
                        fontSize: '28px',
                        fontWeight: 'bold',
                        background: 'linear-gradient(135deg, #ff69b4, #ff1493)',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent',
                        margin: '0 0 8px 0'
                    }}>KopiCatz Admin</h2>
                    <p style={{ color: '#6b7280', margin: 0, fontSize: '14px' }}>Welcome back! Please login to continue.</p>
                </div>

                {/* Form */}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    <div>
                        <label style={{ display: 'block', fontSize: '14px', fontWeight: '500', color: '#374151', marginBottom: '8px' }}>
                            Username
                        </label>
                        <input 
                            type="text" 
                            placeholder="Enter your username" 
                            value={username}
                            onChange={(e) => setUsername(e.target.value)}
                            onKeyPress={(e) => e.key === 'Enter' && handleLogin()}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                borderRadius: '12px',
                                border: '2px solid #ffc0cb',
                                background: 'rgba(255, 255, 255, 0.5)',
                                fontSize: '14px',
                                boxSizing: 'border-box'
                            }}
                        />
                    </div>

                    <div>
                        <label style={{ display: 'block', fontSize: '14px', fontWeight: '500', color: '#374151', marginBottom: '8px' }}>
                            Password
                        </label>
                        <input 
                            type="password" 
                            placeholder="Enter your password" 
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            onKeyPress={(e) => e.key === 'Enter' && handleLogin()}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                borderRadius: '12px',
                                border: '2px solid #ffc0cb',
                                background: 'rgba(255, 255, 255, 0.5)',
                                fontSize: '14px',
                                boxSizing: 'border-box'
                            }}
                        />
                    </div>

                    <button 
                        onClick={handleLogin}
                        style={{
                            width: '100%',
                            background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
                            color: 'white',
                            fontWeight: '600',
                            padding: '12px 16px',
                            borderRadius: '12px',
                            border: 'none',
                            cursor: 'pointer',
                            fontSize: '16px',
                            boxShadow: '0 10px 15px -3px rgba(255, 105, 180, 0.3)'
                        }}
                    >
                        Login to Dashboard
                    </button>
                </div>
                
            </div>
        </div>
    );
};

export default Login;