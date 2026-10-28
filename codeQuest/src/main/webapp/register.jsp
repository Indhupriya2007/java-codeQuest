```jsp
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
    <title>Create Account | CodeQuest</title>
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">

    <style>
        :root {
            --register-cyan: #71e8ff;
            --register-lime: #d7ff64;
            --register-purple: #b5a0ff;
        }

        * {
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            background:
                radial-gradient(ellipse at 12% 15%, rgba(113,232,255,.065), transparent 34%),
                radial-gradient(ellipse at 90% 85%, rgba(181,160,255,.055), transparent 32%),
                #0b0c0a;
        }

        .register-shell {
            min-height: 100vh;
            display: grid;
            grid-template-columns: minmax(0, 1.05fr) minmax(400px, .95fr);
        }

        .register-story {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 100vh;
            padding: 38px clamp(30px, 5vw, 76px);
            border-right: 1px solid rgba(255,255,255,.08);
            overflow: hidden;
            isolation: isolate;
        }

        .register-story::before {
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

        .register-story::after {
            content: "";
            position: absolute;
            width: 370px;
            height: 370px;
            right: -155px;
            top: 25%;
            z-index: -1;
            border: 1px solid rgba(113,232,255,.12);
            border-radius: 50%;
            box-shadow:
                0 0 0 35px rgba(113,232,255,.018),
                0 0 0 75px rgba(113,232,255,.014),
                inset 0 0 65px rgba(113,232,255,.025);
        }

        .register-brand,
        .mobile-brand {
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
            color: var(--register-lime);
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
            color: var(--register-lime);
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
            width: min(100%, 550px);
            margin-block: 60px;
        }

        .system-label {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 8px 11px;
            border: 1px solid rgba(113,232,255,.2);
            border-radius: 3px;
            background: rgba(113,232,255,.035);
            color: var(--register-cyan);
            font-family: var(--font-code);
            font-size: 10px;
            letter-spacing: 1.2px;
            text-transform: uppercase;
        }

        .system-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--register-lime);
            box-shadow: 0 0 10px rgba(215,255,100,.6);
            animation: signal 2s ease-in-out infinite;
        }

        .story-content h1 {
            margin: 27px 0 20px;
            font-size: clamp(42px, 5vw, 68px);
            line-height: 1.05;
            letter-spacing: -3.5px;
            font-weight: 800;
        }

        .line-accent {
            color: var(--register-lime);
        }

        .line-cyan {
            color: var(--register-cyan);
        }

        .story-description {
            max-width: 420px;
            color: #9b9e92;
            font-size: 14px;
            line-height: 1.95;
        }

        .feature-list {
            display: grid;
            gap: 12px;
            margin-top: 32px;
        }

        .feature-item {
            display: flex;
            align-items: center;
            gap: 13px;
            color: #c8cbbf;
            font-size: 12px;
        }

        .feature-icon {
            width: 34px;
            height: 34px;
            flex-shrink: 0;
            display: grid;
            place-items: center;
            border: 1px solid rgba(215,255,100,.18);
            border-radius: 5px;
            background: rgba(215,255,100,.04);
            color: var(--register-lime);
            font-family: var(--font-code);
            font-size: 13px;
        }

        .feature-item small {
            display: block;
            margin-top: 3px;
            color: #777d70;
            font-size: 10px;
        }

        .story-footer {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            color: #72776b;
            font-family: var(--font-code);
            font-size: 10px;
        }

        .story-footer span:last-child {
            color: var(--register-cyan);
        }

        .register-main {
            position: relative;
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 30px;
        }

        .register-main::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            border-top: 1px solid rgba(113,232,255,.12);
            border-right: 1px solid rgba(113,232,255,.12);
            pointer-events: none;
        }

        .register-main::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 100px;
            border-bottom: 1px solid rgba(215,255,100,.1);
            border-left: 1px solid rgba(215,255,100,.1);
            pointer-events: none;
        }

        .register-card {
            position: relative;
            width: min(100%, 430px);
            padding: clamp(25px, 3.5vw, 37px);
            border: 1px solid rgba(255,255,255,.105);
            border-radius: 9px;
            background:
                linear-gradient(145deg, rgba(113,232,255,.025), transparent 35%),
                rgba(18,20,16,.95);
            box-shadow:
                0 25px 75px rgba(0,0,0,.24),
                0 0 35px rgba(113,232,255,.025);
        }

        .register-card::before {
            content: "";
            position: absolute;
            top: -1px;
            left: 22px;
            width: 75px;
            height: 2px;
            background: linear-gradient(90deg, var(--register-cyan), transparent);
            box-shadow: 0 0 14px rgba(113,232,255,.3);
        }

        .card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 23px;
        }

        .register-icon {
            width: 42px;
            height: 42px;
            display: grid;
            place-items: center;
            border: 1px solid rgba(215,255,100,.24);
            border-radius: 6px;
            background: rgba(215,255,100,.045);
            color: var(--register-lime);
            font-family: var(--font-code);
            font-size: 17px;
        }

        .auth-mode {
            color: #777d70;
            font-family: var(--font-code);
            font-size: 10px;
            letter-spacing: 1px;
        }

        .register-heading {
            margin: 0 0 9px;
            font-size: clamp(28px, 3vw, 34px);
            font-weight: 800;
            letter-spacing: -1.5px;
        }

        .register-subheading {
            margin: 0 0 23px;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.9;
        }

        .register-subheading span {
            color: var(--register-cyan);
        }

        .form-message {
            margin-bottom: 18px;
            padding: 12px 13px;
            border: 1px solid rgba(255,120,111,.3);
            border-radius: 4px;
            background: rgba(255,120,111,.055);
            color: #ffaaa4;
            font-size: 12px;
            line-height: 1.7;
        }

        .field {
            margin-bottom: 16px;
        }

        .field label {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            color: #dfe1d7;
            font-size: 12px;
            font-weight: 700;
        }

        .field-index {
            color: #72796b;
            font-family: var(--font-code);
            font-size: 9px;
            font-weight: 400;
        }

        .input-wrap {
            position: relative;
        }

        .input-wrap input {
            min-height: 46px;
            padding: 12px 14px;
            border-color: rgba(255,255,255,.12);
            background: #0e100d;
            font-size: 12px;
        }

        .input-wrap input:hover {
            border-color: rgba(113,232,255,.25);
        }

        .input-wrap input:focus {
            border-color: var(--register-cyan);
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
            color: var(--register-cyan);
        }

        .password-hint {
            margin-top: 7px;
            color: #72796b;
            font-size: 10px;
            line-height: 1.6;
        }

        .password-match {
            min-height: 15px;
            margin-top: 7px;
            color: var(--register-cyan);
            font-size: 10px;
        }

        .password-match.invalid {
            color: var(--danger);
        }

        .password-match.valid {
            color: var(--success);
        }

        .register-submit {
            width: 100%;
            min-height: 48px;
            margin-top: 6px;
            border: 1px solid var(--register-lime);
            border-radius: 4px;
            background: var(--register-lime);
            color: #15190b;
            font-size: 12px;
            font-weight: 800;
            transition:
                transform 180ms ease,
                box-shadow 180ms ease,
                filter 180ms ease;
        }

        .register-submit:hover {
            transform: translateY(-2px);
            filter: brightness(1.06);
            box-shadow: 0 8px 25px rgba(215,255,100,.13);
        }

        .register-submit:active {
            transform: translateY(0);
        }

        .register-submit span {
            display: inline-block;
            margin-left: 8px;
            font-family: var(--font-code);
            transition: transform 180ms ease;
        }

        .register-submit:hover span {
            transform: translateX(4px);
        }

        .auth-divider {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 23px 0;
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
            color: var(--register-lime);
            font-weight: 800;
        }

        .auth-switch a:hover {
            color: var(--register-cyan);
        }

        .auth-home {
            display: block;
            margin-top: 22px;
            text-align: center;
            color: #777d70;
            font-family: var(--font-code);
            font-size: 10px;
        }

        .auth-home:hover {
            color: var(--register-cyan);
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
            .register-shell {
                grid-template-columns: minmax(0, .85fr) minmax(380px, 1fr);
            }

            .register-story {
                padding-inline: 30px;
            }

            .story-content h1 {
                font-size: clamp(38px, 5vw, 54px);
                letter-spacing: -2.8px;
            }

            .register-main {
                padding: 24px;
            }
        }

        @media (max-width: 740px) {
            .register-shell {
                display: block;
            }

            .register-story {
                display: none;
            }

            .register-main {
                min-height: 100vh;
                padding: 25px 20px;
                grid-template-rows: auto 1fr;
                gap: 28px;
            }

            .mobile-brand {
                display: inline-flex;
                justify-self: start;
            }

            .register-card {
                width: min(100%, 440px);
                justify-self: center;
            }
        }

        @media (max-width: 400px) {
            .register-main {
                padding-inline: 14px;
            }

            .register-card {
                padding: 24px 19px;
            }

            .register-heading {
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
    <main class="register-shell">

        <section class="register-story">
            <a class="register-brand" href="<%= contextPath %>/index.jsp">
                <div class="brand-mark">&lt;/&gt;</div>
                <div>
                    <div class="brand-name">Code<span>Quest</span></div>
                    <div class="brand-caption">Level up your logic</div>
                </div>
            </a>

            <div class="story-content">
                <div class="system-label">
                    <span class="system-dot"></span>
                    New player registration
                </div>

                <h1>
                    Don't just<br>
                    play the game.<br>
                    <span class="line-accent">Master</span> <span class="line-cyan">it.</span>
                </h1>

                <p class="story-description">
                    Build your coding skills one challenge at a time.
                    Create your player profile and start turning logic
                    into your strongest skill.
                </p>

                <div class="feature-list">
                    <div class="feature-item">
                        <div class="feature-icon">⌘</div>
                        <div>
                            Solve coding challenges
                            <small>Think sharper with every problem.</small>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="feature-icon">↗</div>
                        <div>
                            Track your progress
                            <small>Keep moving toward your next level.</small>
                        </div>
                    </div>

                    <div class="feature-item">
                        <div class="feature-icon">◇</div>
                        <div>
                            Build your developer mindset
                            <small>Consistency beats shortcuts.</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="story-footer">
                <span>CODEQUEST / PLAYER PORTAL</span>
                <span>YOUR JOURNEY STARTS HERE</span>
            </div>
        </section>

        <section class="register-main">
            <a class="mobile-brand" href="<%= contextPath %>/index.jsp">
                <div class="brand-mark">&lt;/&gt;</div>
                <div>
                    <div class="brand-name">Code<span>Quest</span></div>
                    <div class="brand-caption">Level up your logic</div>
                </div>
            </a>

            <div class="register-card">
                <div class="card-top">
                    <div class="register-icon">{ }</div>
                    <span class="auth-mode">REGISTER / 02</span>
                </div>

                <h2 class="register-heading">Create your account.</h2>
                <p class="register-subheading">
                    Your next chapter starts here.
                    <span>Choose your player credentials.</span>
                </p>

                <div id="formMessage" class="form-message" role="alert" hidden></div>

                <form action="<%= contextPath %>/auth" method="post" id="registerForm">
                    <input type="hidden" name="action" value="register">

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
                                placeholder="Choose a username"
                                minlength="3"
                                maxlength="50"
                                autocomplete="username"
                                required>
                        </div>
                    </div>

                    <div class="field">
                        <label for="email">
                            Email address
                            <span class="field-index">02 / CONTACT</span>
                        </label>
                        <div class="input-wrap">
                            <input
                                type="email"
                                id="email"
                                name="email"
                                placeholder="you@example.com"
                                maxlength="100"
                                autocomplete="email"
                                required>
                        </div>
                    </div>

                    <div class="field">
                        <label for="password">
                            Password
                            <span class="field-index">03 / ACCESS KEY</span>
                        </label>
                        <div class="input-wrap password-wrap">
                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Create a strong password"
                                minlength="8"
                                maxlength="256"
                                autocomplete="new-password"
                                required>
                            <button
                                type="button"
                                class="password-toggle"
                                data-target="password"
                                aria-label="Show password"
                                aria-pressed="false">SHOW</button>
                        </div>
                        <div class="password-hint">Use at least 8 characters.</div>
                    </div>

                    <div class="field">
                        <label for="confirmPassword">
                            Confirm password
                            <span class="field-index">04 / VERIFY</span>
                        </label>
                        <div class="input-wrap password-wrap">
                            <input
                                type="password"
                                id="confirmPassword"
                                placeholder="Re-enter your password"
                                minlength="8"
                                maxlength="256"
                                autocomplete="new-password"
                                required>
                            <button
                                type="button"
                                class="password-toggle"
                                data-target="confirmPassword"
                                aria-label="Show confirmation password"
                                aria-pressed="false">SHOW</button>
                        </div>
                        <div id="passwordMatch" class="password-match" aria-live="polite"></div>
                    </div>

                    <button type="submit" class="register-submit">
                        Create my account <span>→</span>
                    </button>
                </form>

                <div class="auth-divider">ALREADY A PLAYER?</div>

                <div class="auth-switch">
                    Already have an account?
                    <a href="<%= contextPath %>/login.jsp">Sign in ↗</a>
                </div>

                <a class="auth-home" href="<%= contextPath %>/index.jsp">
                    ← BACK TO HOME
                </a>
            </div>
        </section>

    </main>

    <script>
        (function () {
            const params = new URLSearchParams(window.location.search);
            const message = document.getElementById('formMessage');

            if (params.get('error') === 'exists') {
                message.textContent = 'That username or email is already registered. Try another one or sign in.';
                message.hidden = false;
            } else if (params.get('error') === 'server') {
                message.textContent = 'Something went wrong while creating your account. Please try again.';
                message.hidden = false;
            }

            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordMatch = document.getElementById('passwordMatch');
            const form = document.getElementById('registerForm');

            document.querySelectorAll('.password-toggle').forEach(function (button) {
                button.addEventListener('click', function () {
                    const input = document.getElementById(button.dataset.target);
                    const showing = input.type === 'password';

                    input.type = showing ? 'text' : 'password';
                    button.textContent = showing ? 'HIDE' : 'SHOW';
                    button.setAttribute('aria-pressed', String(showing));
                    button.setAttribute(
                        'aria-label',
                        (showing ? 'Hide' : 'Show') +
                        (input.id === 'password' ? ' password' : ' confirmation password')
                    );
                });
            });

            function validatePasswordMatch() {
                const first = password.value;
                const second = confirmPassword.value;

                passwordMatch.classList.remove('valid', 'invalid');

                if (!second) {
                    passwordMatch.textContent = '';
                    confirmPassword.setCustomValidity('');
                    return true;
                }

                if (first === second) {
                    passwordMatch.textContent = '✓ Passwords match';
                    passwordMatch.classList.add('valid');
                    confirmPassword.setCustomValidity('');
                    return true;
                }

                passwordMatch.textContent = 'Passwords do not match yet.';
                passwordMatch.classList.add('invalid');
                confirmPassword.setCustomValidity('Passwords do not match.');
                return false;
            }

            password.addEventListener('input', validatePasswordMatch);
            confirmPassword.addEventListener('input', validatePasswordMatch);

            form.addEventListener('submit', function (event) {
                if (!validatePasswordMatch()) {
                    event.preventDefault();
                    confirmPassword.reportValidity();
                }
            });
        })();
    </script>
</body>
</html>
```
