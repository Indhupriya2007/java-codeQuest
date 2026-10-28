<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String contextPath = request.getContextPath();

    if (session.getAttribute("userId") != null) {
        response.sendRedirect(contextPath + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="theme-color" content="#0b0c0a">
    <title>Login | CodeQuest</title>
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">

    <style>
        :root {
            --login-cyan: #71e8ff;
            --login-lime: #d7ff64;
            --login-purple: #b5a0ff;
        }

        * {
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            overflow-x: hidden;
            background:
                radial-gradient(ellipse at 13% 18%, rgba(113,232,255,.07), transparent 35%),
                radial-gradient(ellipse at 88% 85%, rgba(181,160,255,.055), transparent 32%),
                #0b0c0a;
        }

        .auth-shell {
            min-height: 100vh;
            display: grid;
            grid-template-columns: minmax(0, 1.05fr) minmax(390px, .95fr);
        }

        .auth-story {
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 38px clamp(30px, 5vw, 76px);
            border-right: 1px solid rgba(255,255,255,.08);
            overflow: hidden;
            isolation: isolate;
        }

        .auth-story::before {
            content: "";
            position: absolute;
            inset: 0;
            z-index: -2;
            background-image:
                linear-gradient(rgba(113,232,255,.045) 1px, transparent 1px),
                linear-gradient(90deg, rgba(113,232,255,.045) 1px, transparent 1px);
            background-size: 42px 42px;
            mask-image: linear-gradient(to bottom right, black, transparent 85%);
        }

        .auth-story::after {
            content: "";
            position: absolute;
            width: 380px;
            height: 380px;
            right: -150px;
            top: 25%;
            z-index: -1;
            border: 1px solid rgba(113,232,255,.12);
            border-radius: 50%;
            box-shadow:
                0 0 0 35px rgba(113,232,255,.018),
                0 0 0 75px rgba(113,232,255,.015),
                inset 0 0 65px rgba(113,232,255,.025);
        }

        .auth-brand {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            width: fit-content;
        }

        .brand-mark {
            width: 42px;
            height: 42px;
            display: grid;
            place-items: center;
            border: 1px solid rgba(215,255,100,.55);
            border-radius: 10px 3px 10px 3px;
            background: rgba(215,255,100,.07);
            color: var(--login-lime);
            font-family: var(--font-code);
            font-size: 18px;
            box-shadow: 0 0 24px rgba(215,255,100,.07);
        }

        .brand-name {
            font-size: 19px;
            font-weight: 800;
            letter-spacing: -.7px;
        }

        .brand-name span {
            color: var(--login-lime);
        }

        .brand-caption {
            margin-top: 3px;
            color: var(--muted);
            font-family: var(--font-code);
            font-size: 10px;
            letter-spacing: 1.3px;
            text-transform: uppercase;
        }

        .story-content {
            width: min(100%, 560px);
            margin-block: 70px;
        }

        .system-label {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 8px 11px;
            border: 1px solid rgba(113,232,255,.2);
            border-radius: 3px;
            background: rgba(113,232,255,.035);
            color: var(--login-cyan);
            font-family: var(--font-code);
            font-size: 10px;
            letter-spacing: 1.2px;
            text-transform: uppercase;
        }

        .system-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--login-lime);
            box-shadow: 0 0 10px rgba(215,255,100,.6);
            animation: signal 2s ease-in-out infinite;
        }

        .story-content h1 {
            max-width: 600px;
            margin: 27px 0 20px;
            font-size: clamp(42px, 5vw, 69px);
            line-height: 1.04;
            letter-spacing: -3.8px;
            font-weight: 800;
        }

        .story-content h1 .line-accent {
            color: var(--login-lime);
        }

        .story-content h1 .line-cyan {
            color: var(--login-cyan);
        }

        .story-description {
            max-width: 430px;
            color: #9b9e92;
            font-size: 14px;
            line-height: 1.95;
        }

        .terminal-card {
            max-width: 430px;
            margin-top: 38px;
            border: 1px solid rgba(255,255,255,.1);
            border-radius: 7px;
            background: rgba(16,18,14,.82);
            overflow: hidden;
            box-shadow: 0 18px 55px rgba(0,0,0,.18);
            backdrop-filter: blur(10px);
        }

        .terminal-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 15px;
            border-bottom: 1px solid rgba(255,255,255,.08);
            background: rgba(255,255,255,.018);
        }

        .terminal-lights {
            display: flex;
            gap: 6px;
        }

        .terminal-lights i {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #45483f;
        }

        .terminal-lights i:first-child {
            background: #ff786f;
        }

        .terminal-lights i:nth-child(2) {
            background: #e9c66c;
        }

        .terminal-lights i:nth-child(3) {
            background: var(--login-lime);
        }

        .terminal-label {
            color: #73796c;
            font-family: var(--font-code);
            font-size: 10px;
        }

        .terminal-body {
            padding: 17px;
            font-family: var(--font-code);
            font-size: 11px;
            line-height: 2.2;
        }

        .terminal-line {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .terminal-prompt {
            color: var(--login-lime);
        }

        .terminal-command {
            color: #e1e5d9;
        }

        .terminal-comment {
            color: #72796a;
        }

        .terminal-output {
            color: var(--login-cyan);
        }

        .story-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            color: #72776b;
            font-family: var(--font-code);
            font-size: 10px;
        }

        .story-footer span:last-child {
            color: var(--login-cyan);
        }

        .auth-main {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 36px;
            position: relative;
        }

        .auth-main::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 115px;
            height: 115px;
            border-top: 1px solid rgba(113,232,255,.12);
            border-right: 1px solid rgba(113,232,255,.12);
            pointer-events: none;
        }

        .auth-main::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 115px;
            height: 115px;
            border-bottom: 1px solid rgba(215,255,100,.1);
            border-left: 1px solid rgba(215,255,100,.1);
            pointer-events: none;
        }

        .auth-card {
            width: min(100%, 410px);
            position: relative;
            padding: clamp(25px, 4vw, 39px);
            border: 1px solid rgba(255,255,255,.105);
            border-radius: 9px;
            background:
                linear-gradient(145deg, rgba(113,232,255,.025), transparent 35%),
                rgba(18,20,16,.94);
            box-shadow:
                0 25px 75px rgba(0,0,0,.24),
                0 0 35px rgba(113,232,255,.025);
        }

        .auth-card::before {
            content: "";
            position: absolute;
            top: -1px;
            left: 22px;
            width: 75px;
            height: 2px;
            background: linear-gradient(90deg, var(--login-cyan), transparent);
            box-shadow: 0 0 14px rgba(113,232,255,.3);
        }

        .auth-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 28px;
        }

        .auth-code-icon {
            width: 42px;
            height: 42px;
            display: grid;
            place-items: center;
            border: 1px solid rgba(215,255,100,.24);
            border-radius: 6px;
            background: rgba(215,255,100,.045);
            color: var(--login-lime);
            font-family: var(--font-code);
            font-size: 15px;
        }

        .auth-code-icon span {
            text-shadow: 0 0 12px rgba(215,255,100,.2);
        }

        .auth-mode {
            color: #777d70;
            font-family: var(--font-code);
            font-size: 10px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .auth-heading {
            margin: 0 0 10px;
            font-size: clamp(27px, 3vw, 34px);
            font-weight: 800;
            letter-spacing: -1.4px;
        }

        .auth-subheading {
            margin: 0 0 27px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.8;
        }

        .auth-subheading .highlight {
            color: var(--login-cyan);
        }

        .form-message {
            margin-bottom: 20px;
            padding: 12px 13px;
            border: 1px solid rgba(255,120,111,.3);
            border-radius: 4px;
            background: rgba(255,120,111,.055);
            color: #ffaaa4;
            font-size: 12px;
            line-height: 1.7;
        }

        .form-message.success {
            border-color: rgba(168,255,145,.25);
            background: rgba(168,255,145,.045);
            color: var(--success);
        }

        .field {
            margin-bottom: 19px;
        }

        .field label {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 9px;
            color: #dfe1d7;
            font-size: 12px;
            font-weight: 700;
        }

        .field label .field-index {
            color: #72796b;
            font-family: var(--font-code);
            font-size: 10px;
            font-weight: 400;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap input {
            min-height: 49px;
            padding: 13px 14px;
            border-color: rgba(255,255,255,.12);
            background: #0e100d;
            font-size: 13px;
        }

        .input-wrap input:hover {
            border-color: rgba(113,232,255,.25);
        }

        .input-wrap input:focus {
            border-color: var(--login-cyan);
            box-shadow: 0 0 0 3px rgba(113,232,255,.055);
        }

        .password-wrap input {
            padding-right: 65px;
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 12px;
            transform: translateY(-50%);
            padding: 5px 0 5px 8px;
            border: 0;
            background: transparent;
            color: #8b9082;
            font-family: var(--font-code);
            font-size: 10px;
        }

        .password-toggle:hover {
            color: var(--login-cyan);
        }

        .auth-options {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin: 5px 0 23px;
            color: var(--muted);
            font-size: 11px;
        }

        .security-note {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            color: #858b7a;
        }

        .security-note span {
            color: var(--login-cyan);
        }

        .login-submit {
            width: 100%;
            min-height: 49px;
            position: relative;
            overflow: hidden;
            border: 1px solid var(--login-lime);
            border-radius: 4px;
            background: var(--login-lime);
            color: #15190b;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: .3px;
            transition:
                box-shadow 180ms ease,
                transform 180ms ease,
                filter 180ms ease;
        }

        .login-submit:hover {
            transform: translateY(-2px);
            filter: brightness(1.06);
            box-shadow: 0 8px 25px rgba(215,255,100,.13);
        }

        .submit-content {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .submit-arrow {
            font-family: var(--font-code);
            font-size: 15px;
            transition: transform 180ms ease;
        }

        .login-submit:hover .submit-arrow {
            transform: translateX(4px);
        }

        .auth-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 25px 0;
            color: #666c5f;
            font-family: var(--font-code);
            font-size: 10px;
        }

        .auth-divider::before,
        .auth-divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background: rgba(255,255,255,.09);
        }

        .auth-switch {
            text-align: center;
            color: #929789;
            font-size: 12px;
            line-height: 1.9;
        }

        .auth-switch a {
            color: var(--login-lime);
            font-weight: 800;
        }

        .auth-switch a:hover {
            color: var(--login-cyan);
        }

        .auth-home {
            display: block;
            margin-top: 25px;
            text-align: center;
            color: #777d70;
            font-family: var(--font-code);
            font-size: 10px;
            transition: color 180ms ease;
        }

        .auth-home:hover {
            color: var(--login-cyan);
        }

        .auth-home span {
            margin-right: 6px;
        }

        .mobile-brand {
            display: none;
        }

        @keyframes signal {
            0%, 100% {
                opacity: 1;
                box-shadow: 0 0 10px rgba(215,255,100,.6);
            }
            50% {
                opacity: .5;
                box-shadow: 0 0 3px rgba(215,255,100,.2);
            }
        }

        @media (max-width: 960px) {
            .auth-shell {
                grid-template-columns: minmax(0, .85fr) minmax(370px, 1fr);
            }

            .auth-story {
                padding-inline: 30px;
            }

            .story-content h1 {
                font-size: clamp(39px, 5.2vw, 55px);
                letter-spacing: -2.8px;
            }

            .auth-main {
                padding: 25px;
            }
        }

        @media (max-width: 720px) {
            .auth-shell {
                display: block;
            }

            .auth-story {
                display: none;
            }

            .auth-main {
                min-height: 100vh;
                padding: 28px 20px;
                grid-template-rows: auto 1fr;
                gap: 35px;
            }

            .mobile-brand {
                display: inline-flex;
                align-items: center;
                gap: 11px;
                justify-self: start;
            }

            .auth-card {
                width: min(100%, 430px);
                justify-self: center;
            }
        }

        @media (max-width: 400px) {
            .auth-main {
                padding-inline: 15px;
            }

            .auth-card {
                padding: 25px 20px;
            }

            .auth-heading {
                font-size: 29px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: .01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: .01ms !important;
            }
        }
    </style>
</head>

<body>
    <main class="auth-shell">

        <section class="auth-story">
            <a class="auth-brand" href="<%= contextPath %>/index.jsp">
                <div class="brand-mark">&lt;/&gt;</div>
                <div>
                    <div class="brand-name">Code<span>Quest</span></div>
                    <div class="brand-caption">Level up your logic</div>
                </div>
            </a>

            <div class="story-content">
                <div class="system-label">
                    <span class="system-dot"></span>
                    Player authentication
                </div>

                <h1>
                    Your next<br>
                    level starts<br>
                    <span class="line-accent">right</span> <span class="line-cyan">here.</span>
                </h1>

                <p class="story-description">
                    Every problem solved makes you sharper. Jump back into
                    your coding journey, sharpen your skills, and keep
                    building your streak.
                </p>

                <div class="terminal-card">
                    <div class="terminal-top">
                        <div class="terminal-lights">
                            <i></i><i></i><i></i>
                        </div>
                        <span class="terminal-label">player_session.exe</span>
                    </div>

                    <div class="terminal-body">
                        <div class="terminal-line">
                            <span class="terminal-prompt">&gt;</span>
                            <span class="terminal-command">initialize_player()</span>
                        </div>
                        <div class="terminal-line">
                            <span class="terminal-comment">// your next challenge awaits</span>
                        </div>
                        <div class="terminal-line">
                            <span class="terminal-output">[ READY ]</span>
                            <span class="terminal-command">system online</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="story-footer">
                <span>CODEQUEST / PLAYER PORTAL</span>
                <span>BUILD. SOLVE. REPEAT.</span>
            </div>
        </section>

        <section class="auth-main">
            <a class="mobile-brand" href="<%= contextPath %>/index.jsp">
                <div class="brand-mark">&lt;/&gt;</div>
                <div>
                    <div class="brand-name">Code<span>Quest</span></div>
                    <div class="brand-caption">Level up your logic</div>
                </div>
            </a>

            <div class="auth-card">
                <div class="auth-card-top">
                    <div class="auth-code-icon"><span>&lt;/&gt;</span></div>
                    <span class="auth-mode">AUTH / 01</span>
                </div>

                <h2 class="auth-heading">Welcome back.</h2>
                <p class="auth-subheading">
                    Your next breakthrough is waiting.
                    <span class="highlight">Ready to continue?</span>
                </p>

                <div id="formMessage" class="form-message" role="alert" hidden></div>

                <form action="<%= contextPath %>/auth" method="post" id="loginForm">
                    <input type="hidden" name="action" value="login">

                    <div class="field">
                        <label for="username">
                            Username
                            <span class="field-index">01 / PLAYER ID</span>
                        </label>

                        <div class="input-wrap">
                            <input
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Enter your username"
                                maxlength="50"
                                autocomplete="username"
                                required
                                autofocus>
                        </div>
                    </div>

                    <div class="field">
                        <label for="password">
                            Password
                            <span class="field-index">02 / ACCESS KEY</span>
                        </label>

                        <div class="input-wrap password-wrap">
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Enter your password"
                                maxlength="256"
                                autocomplete="current-password"
                                required>

                            <button
                                type="button"
                                class="password-toggle"
                                id="passwordToggle"
                                aria-label="Show password"
                                aria-pressed="false">SHOW</button>
                        </div>
                    </div>

                    <div class="auth-options">
                        <span class="security-note">
                            <span>◈</span> Secure player access
                        </span>
                        <span>Sign in to continue</span>
                    </div>

                    <button type="submit" class="login-submit">
                        <span class="submit-content">
                            Enter CodeQuest
                            <span class="submit-arrow">→</span>
                        </span>
                    </button>
                </form>

                <div class="auth-divider">NEW PLAYER?</div>

                <div class="auth-switch">
                    Don't have an account?
                    <a href="<%= contextPath %>/register.jsp">Create your account ↗</a>
                </div>

                <a class="auth-home" href="<%= contextPath %>/index.jsp">
                    <span>←</span> BACK TO HOME
                </a>
            </div>
        </section>

    </main>

    <script>
        (function () {
            const params = new URLSearchParams(window.location.search);
            const message = document.getElementById('formMessage');

            const messages = {
                invalid: {
                    text: 'Invalid username or password. Please check your details and try again.',
                    type: 'error'
                },
                registered: {
                    text: 'Account created successfully! You can now log in.',
                    type: 'success'
                },
                logout: {
                    text: 'You have been logged out successfully.',
                    type: 'success'
                }
            };

            let currentMessage = null;

            for (const key of ['invalid', 'registered', 'logout']) {
                if (params.get(key) === '1' || (key === 'invalid' && params.has('error'))) {
                    if (key === 'invalid' && params.get('error') !== 'invalid') {
                        continue;
                    }
                    currentMessage = messages[key];
                    break;
                }
            }

            if (currentMessage) {
                message.textContent = currentMessage.text;
                message.classList.toggle('success', currentMessage.type === 'success');
                message.hidden = false;
            }

            const password = document.getElementById('password');
            const toggle = document.getElementById('passwordToggle');

            toggle.addEventListener('click', function () {
                const showing = password.type === 'password';
                password.type = showing ? 'text' : 'password';
                toggle.textContent = showing ? 'HIDE' : 'SHOW';
                toggle.setAttribute('aria-label', showing ? 'Hide password' : 'Show password');
                toggle.setAttribute('aria-pressed', String(showing));
            });
        })();
    </script>
</body>
</html>