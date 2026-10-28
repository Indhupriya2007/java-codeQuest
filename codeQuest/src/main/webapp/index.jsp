<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String contextPath = request.getContextPath();
    boolean loggedIn = session.getAttribute("userId") != null;
    String dashboardLink = contextPath + "/dashboard.jsp";
    String loginLink = contextPath + "/login.jsp";
    String registerLink = contextPath + "/register.jsp";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest — Level Up Your Logic</title>
    <meta name="description" content="Turn coding practice into a quest. Solve challenges, earn XP, and level up your programming skills with CodeQuest.">
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * { box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            margin: 0;
            background: #0b0c0a;
            color: #f0f0e8;
            font-family: 'Manrope', sans-serif;
            overflow-x: hidden;
        }

        a { color: inherit; text-decoration: none; }

        button, a { -webkit-tap-highlight-color: transparent; }

        .cq-nav {
            height: 78px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 7%;
            border-bottom: 1px solid rgba(240,240,232,.08);
            background: rgba(11,12,10,.82);
            backdrop-filter: blur(18px);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .cq-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 800;
            font-size: 21px;
            letter-spacing: -1px;
        }

        .cq-logo {
            width: 38px;
            height: 38px;
            display: grid;
            place-items: center;
            border-radius: 10px;
            background: #d7ff64;
            color: #15190b;
            font-family: 'DM Mono', monospace;
            font-size: 19px;
            box-shadow: 0 0 24px rgba(215,255,100,.12);
        }

        .cq-brand span span { color: #d7ff64; }

        .cq-nav-links {
            display: flex;
            align-items: center;
            gap: 33px;
            color: #96998d;
            font-size: 13px;
            font-weight: 600;
        }

        .cq-nav-links a { transition: color .2s ease; }
        .cq-nav-links a:hover { color: #d7ff64; }

        .cq-nav-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cq-btn {
            min-height: 43px;
            padding: 0 19px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            border-radius: 7px;
            font-size: 12px;
            font-weight: 800;
            border: 1px solid transparent;
            transition: transform .2s ease, background .2s ease, border-color .2s ease;
            cursor: pointer;
        }

        .cq-btn:hover { transform: translateY(-2px); }

        .cq-btn-primary {
            color: #15190b;
            background: #d7ff64;
            box-shadow: 0 0 25px rgba(215,255,100,.08);
        }

        .cq-btn-primary:hover { background: #e3ff94; }

        .cq-btn-outline {
            border-color: rgba(240,240,232,.14);
            color: #f0f0e8;
            background: rgba(255,255,255,.02);
        }

        .cq-btn-outline:hover {
            border-color: rgba(215,255,100,.5);
            background: rgba(215,255,100,.04);
        }

        .cq-hero {
            position: relative;
            min-height: 650px;
            padding: 95px 7% 80px;
            display: grid;
            grid-template-columns: 1.05fr .95fr;
            align-items: center;
            gap: 55px;
            isolation: isolate;
        }

        .cq-hero::before {
            content: "";
            position: absolute;
            inset: 0;
            z-index: -2;
            background-image:
                linear-gradient(rgba(255,255,255,.022) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,.022) 1px, transparent 1px);
            background-size: 48px 48px;
            mask-image: linear-gradient(to bottom, black, transparent 90%);
        }

        .cq-hero::after {
            content: "";
            position: absolute;
            z-index: -1;
            width: 480px;
            height: 480px;
            right: 5%;
            top: 5%;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(113,232,255,.08), rgba(181,160,255,.045) 40%, transparent 70%);
            pointer-events: none;
        }

        .cq-kicker {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: #d7ff64;
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            letter-spacing: 1.8px;
            text-transform: uppercase;
            padding: 10px 13px;
            border: 1px solid rgba(215,255,100,.2);
            background: rgba(215,255,100,.035);
            border-radius: 5px;
        }

        .cq-live-dot {
            height: 7px;
            width: 7px;
            border-radius: 50%;
            background: #d7ff64;
            box-shadow: 0 0 10px rgba(215,255,100,.8);
        }

        .cq-hero h1 {
            margin: 26px 0 22px;
            max-width: 690px;
            font-size: clamp(43px, 5.5vw, 74px);
            font-weight: 800;
            line-height: 1.04;
            letter-spacing: -4px;
        }

        .cq-hero h1 .cq-highlight {
            color: #d7ff64;
            position: relative;
            display: inline-block;
        }

        .cq-hero h1 .cq-highlight::after {
            content: "";
            position: absolute;
            height: 3px;
            width: 75%;
            left: 0;
            bottom: -5px;
            background: linear-gradient(90deg, #d7ff64, #71e8ff, transparent);
        }

        .cq-hero-copy {
            max-width: 510px;
            color: #96998d;
            font-size: 14px;
            line-height: 1.95;
        }

        .cq-hero-actions {
            display: flex;
            gap: 13px;
            flex-wrap: wrap;
            margin-top: 32px;
        }

        .cq-hero-actions .cq-btn {
            min-height: 50px;
            padding: 0 23px;
        }

        .cq-hero-meta {
            margin-top: 34px;
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
            color: #777d70;
            font-family: 'DM Mono', monospace;
            font-size: 10px;
        }

        .cq-hero-meta span {
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .cq-hero-meta b { color: #c6cabb; font-weight: 400; }

        .cq-console-wrap {
            position: relative;
            max-width: 520px;
            width: 100%;
            margin: auto;
        }

        .cq-console-glow {
            position: absolute;
            inset: 10% -5%;
            background: radial-gradient(ellipse, rgba(215,255,100,.09), transparent 68%);
            filter: blur(25px);
            pointer-events: none;
        }

        .cq-console {
            position: relative;
            border: 1px solid rgba(240,240,232,.13);
            border-radius: 12px;
            overflow: hidden;
            background: rgba(16,18,14,.94);
            box-shadow: 0 30px 100px rgba(0,0,0,.45), 0 0 40px rgba(113,232,255,.035);
            transform: perspective(1100px) rotateY(-3deg);
            transition: transform .4s ease, border-color .3s ease;
        }

        .cq-console:hover {
            transform: perspective(1100px) rotateY(0);
            border-color: rgba(215,255,100,.3);
        }

        .cq-console-top {
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 17px;
            background: rgba(255,255,255,.025);
            border-bottom: 1px solid rgba(255,255,255,.08);
        }

        .cq-window-dots { display: flex; gap: 6px; }

        .cq-window-dots i {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #53564c;
        }

        .cq-window-dots i:first-child { background: #ff786f; }
        .cq-window-dots i:nth-child(2) { background: #d7ff64; }
        .cq-window-dots i:nth-child(3) { background: #71e8ff; }

        .cq-console-title {
            color: #888e80;
            font: 10px 'DM Mono', monospace;
        }

        .cq-console-status {
            color: #a8ff91;
            font: 9px 'DM Mono', monospace;
        }

        .cq-code-area {
            padding: 25px 23px 23px;
            font: 12px/2.05 'DM Mono', monospace;
            overflow: hidden;
        }

        .cq-code-line {
            display: flex;
            gap: 19px;
            white-space: nowrap;
        }

        .cq-line-no {
            color: #51564a;
            min-width: 13px;
            text-align: right;
            user-select: none;
        }

        .cq-code-comment { color: #727a68; }
        .cq-code-key { color: #b5a0ff; }
        .cq-code-fn { color: #71e8ff; }
        .cq-code-string { color: #d7ff64; }
        .cq-code-number { color: #ffb68b; }
        .cq-code-text { color: #d6d9cc; }

        .cq-code-cursor {
            display: inline-block;
            width: 6px;
            height: 13px;
            background: #d7ff64;
            vertical-align: middle;
            animation: cqBlink 1s steps(2, start) infinite;
        }

        @keyframes cqBlink { to { visibility: hidden; } }

        .cq-console-bottom {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            border-top: 1px solid rgba(255,255,255,.08);
        }

        .cq-mini-stat {
            padding: 16px;
            border-right: 1px solid rgba(255,255,255,.07);
        }

        .cq-mini-stat:last-child { border-right: none; }

        .cq-mini-stat small {
            display: block;
            color: #7d8375;
            font: 9px 'DM Mono', monospace;
            margin-bottom: 7px;
        }

        .cq-mini-stat strong {
            font-size: 17px;
            letter-spacing: -.5px;
        }

        .cq-mini-stat strong span {
            font-size: 10px;
            color: #d7ff64;
            font-weight: 500;
        }

        .cq-float-tag {
            position: absolute;
            padding: 12px 15px;
            border-radius: 8px;
            border: 1px solid rgba(240,240,232,.12);
            background: rgba(19,22,17,.95);
            backdrop-filter: blur(12px);
            box-shadow: 0 15px 40px rgba(0,0,0,.3);
            display: flex;
            align-items: center;
            gap: 11px;
            animation: cqFloat 5s ease-in-out infinite;
        }

        .cq-float-icon {
            width: 34px;
            height: 34px;
            display: grid;
            place-items: center;
            background: rgba(215,255,100,.09);
            color: #d7ff64;
            border-radius: 7px;
            font: 15px 'DM Mono', monospace;
        }

        .cq-float-tag small {
            display: block;
            font: 9px 'DM Mono', monospace;
            color: #858b7b;
            margin-bottom: 4px;
        }

        .cq-float-tag strong { font-size: 11px; }

        .cq-float-one { top: 14%; right: -32px; }
        .cq-float-two { bottom: 12%; left: -37px; animation-delay: -2s; }

        @keyframes cqFloat {
            0%,100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        .cq-strip {
            margin: 0 7%;
            padding: 23px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            border-top: 1px solid rgba(240,240,232,.09);
            border-bottom: 1px solid rgba(240,240,232,.09);
            flex-wrap: wrap;
        }

        .cq-strip-label {
            color: #6f7568;
            font: 9px 'DM Mono', monospace;
            letter-spacing: 1.4px;
            text-transform: uppercase;
        }

        .cq-tech-list {
            display: flex;
            gap: 27px;
            align-items: center;
            flex-wrap: wrap;
        }

        .cq-tech {
            color: #a5a99c;
            font-size: 12px;
            font-weight: 800;
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .cq-tech-icon {
            color: #d7ff64;
            font: 12px 'DM Mono', monospace;
        }

        .cq-section {
            padding: 105px 7%;
        }

        .cq-section-head {
            max-width: 640px;
            margin-bottom: 44px;
        }

        .cq-section-label {
            color: #d7ff64;
            font: 10px 'DM Mono', monospace;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .cq-section h2 {
            font-size: clamp(30px, 4vw, 47px);
            line-height: 1.15;
            letter-spacing: -2px;
            margin: 18px 0;
        }

        .cq-section h2 span { color: #d7ff64; }

        .cq-section-head p {
            color: #929789;
            font-size: 13px;
            line-height: 1.9;
        }

        .cq-feature-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 17px;
        }

        .cq-feature {
            position: relative;
            min-height: 245px;
            padding: 27px;
            background: linear-gradient(145deg, rgba(255,255,255,.035), rgba(255,255,255,.008));
            border: 1px solid rgba(240,240,232,.1);
            border-radius: 9px;
            overflow: hidden;
            transition: transform .25s ease, border-color .25s ease, background .25s ease;
        }

        .cq-feature::after {
            content: "";
            position: absolute;
            width: 140px;
            height: 140px;
            right: -60px;
            bottom: -75px;
            border-radius: 50%;
            background: rgba(215,255,100,.05);
            filter: blur(12px);
            transition: background .25s ease;
        }

        .cq-feature:hover {
            transform: translateY(-5px);
            border-color: rgba(215,255,100,.28);
            background: linear-gradient(145deg, rgba(215,255,100,.045), rgba(255,255,255,.008));
        }

        .cq-feature:hover::after { background: rgba(113,232,255,.1); }

        .cq-feature-icon {
            width: 45px;
            height: 45px;
            border: 1px solid rgba(215,255,100,.2);
            background: rgba(215,255,100,.06);
            color: #d7ff64;
            display: grid;
            place-items: center;
            border-radius: 9px;
            font: 18px 'DM Mono', monospace;
        }

        .cq-feature:nth-child(2) .cq-feature-icon {
            color: #71e8ff;
            border-color: rgba(113,232,255,.2);
            background: rgba(113,232,255,.05);
        }

        .cq-feature:nth-child(3) .cq-feature-icon {
            color: #b5a0ff;
            border-color: rgba(181,160,255,.2);
            background: rgba(181,160,255,.05);
        }

        .cq-feature h3 {
            margin: 23px 0 10px;
            font-size: 16px;
            letter-spacing: -.3px;
        }

        .cq-feature p {
            margin: 0;
            max-width: 300px;
            color: #8d9384;
            font-size: 12px;
            line-height: 1.9;
        }

        .cq-feature-index {
            position: absolute;
            right: 24px;
            top: 28px;
            color: #4e5447;
            font: 10px 'DM Mono', monospace;
        }

        .cq-quest-section {
            padding: 0 7% 100px;
        }

        .cq-quest-panel {
            position: relative;
            display: grid;
            grid-template-columns: 1fr auto;
            align-items: center;
            gap: 30px;
            padding: 48px;
            border-radius: 12px;
            border: 1px solid rgba(215,255,100,.19);
            background:
                radial-gradient(ellipse at 90% 10%, rgba(113,232,255,.07), transparent 35%),
                linear-gradient(115deg, rgba(215,255,100,.06), rgba(255,255,255,.012));
            overflow: hidden;
        }

        .cq-quest-panel::before {
            content: "</>";
            position: absolute;
            right: 19%;
            top: -35px;
            font: 160px 'DM Mono', monospace;
            color: rgba(240,240,232,.025);
            pointer-events: none;
        }

        .cq-quest-panel h2 {
            margin: 14px 0;
            max-width: 570px;
            font-size: clamp(28px, 3.5vw, 41px);
            letter-spacing: -1.8px;
            line-height: 1.15;
        }

        .cq-quest-panel p {
            margin: 0;
            max-width: 500px;
            color: #969b8d;
            font-size: 12px;
            line-height: 1.9;
        }

        .cq-quest-actions {
            position: relative;
            z-index: 1;
        }

        .cq-footer {
            padding: 30px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            border-top: 1px solid rgba(240,240,232,.08);
            color: #777d70;
            font-size: 10px;
            flex-wrap: wrap;
        }

        .cq-footer-brand {
            display: flex;
            align-items: center;
            gap: 9px;
            color: #e5e7dc;
            font-weight: 800;
            font-size: 13px;
        }

        .cq-footer-brand span { color: #d7ff64; }

        .cq-footer-links {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .cq-footer-links a:hover { color: #d7ff64; }

        .cq-reveal {
            opacity: 0;
            transform: translateY(18px);
            transition: opacity .65s ease, transform .65s ease;
        }

        .cq-reveal.cq-visible {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 1000px) {
            .cq-nav { padding: 0 5%; }
            .cq-hero { padding: 75px 5%; gap: 35px; }
            .cq-hero h1 { letter-spacing: -2.5px; }
            .cq-float-one { right: -10px; }
            .cq-float-two { left: -10px; }
            .cq-strip { margin: 0 5%; }
            .cq-section { padding: 85px 5%; }
            .cq-quest-section { padding: 0 5% 80px; }
            .cq-feature { padding: 22px; }
        }

        @media (max-width: 760px) {
            .cq-nav { height: 68px; }
            .cq-nav-links { display: none; }
            .cq-brand { font-size: 18px; }
            .cq-logo { width: 34px; height: 34px; }
            .cq-btn { padding: 0 13px; }
            .cq-hero {
                grid-template-columns: 1fr;
                padding: 70px 6% 75px;
                gap: 65px;
            }
            .cq-hero h1 { font-size: clamp(44px, 11vw, 66px); }
            .cq-hero-copy { font-size: 13px; }
            .cq-console-wrap { max-width: 500px; }
            .cq-console { transform: none; }
            .cq-float-one { right: -5px; top: -28px; }
            .cq-float-two { left: -5px; bottom: -28px; }
            .cq-strip { margin: 0 6%; }
            .cq-strip-label { width: 100%; }
            .cq-tech-list { gap: 18px; }
            .cq-section { padding: 75px 6%; }
            .cq-feature-grid { grid-template-columns: 1fr; }
            .cq-feature { min-height: auto; padding: 25px; }
            .cq-quest-section { padding: 0 6% 70px; }
            .cq-quest-panel { grid-template-columns: 1fr; padding: 30px 25px; }
            .cq-quest-panel::before { right: 2%; top: 5%; font-size: 100px; }
            .cq-footer { padding: 27px 6%; }
        }

        @media (max-width: 420px) {
            .cq-nav-actions { gap: 7px; }
            .cq-nav-actions .cq-btn { font-size: 10px; min-height: 38px; padding: 0 10px; }
            .cq-hero h1 { letter-spacing: -2px; }
            .cq-hero-meta { gap: 14px; }
            .cq-code-area { padding: 18px 12px; font-size: 10px; }
            .cq-code-line { gap: 10px; }
            .cq-mini-stat { padding: 12px 9px; }
            .cq-mini-stat strong { font-size: 15px; }
            .cq-float-tag { padding: 9px 11px; }
            .cq-float-icon { width: 29px; height: 29px; }
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: .01ms !important;
                animation-iteration-count: 1 !important;
                scroll-behavior: auto !important;
                transition-duration: .01ms !important;
            }
        }
    </style>
</head>
<body>

<header class="cq-nav">
    <a class="cq-brand" href="<%= contextPath %>/index.jsp" aria-label="CodeQuest home">
        <span class="cq-logo">&lt;/&gt;</span>
        <span>code<span>quest</span></span>
    </a>

    <nav class="cq-nav-links" aria-label="Main navigation">
        <a href="#features">Features</a>
        <a href="#how-it-works">The Quest</a>
        <a href="#languages">Languages</a>
    </nav>

    <div class="cq-nav-actions">
        <% if (loggedIn) { %>
            <a class="cq-btn cq-btn-outline" href="<%= dashboardLink %>">My Dashboard ↗</a>
        <% } else { %>
            <a class="cq-btn cq-btn-outline" href="<%= loginLink %>">Log in</a>
            <a class="cq-btn cq-btn-primary" href="<%= registerLink %>">Start quest <span>↗</span></a>
        <% } %>
    </div>
</header>

<main>
    <section class="cq-hero">
        <div class="cq-hero-content">
            <div class="cq-kicker">
                <span class="cq-live-dot"></span>
                YOUR NEXT LEVEL STARTS HERE
            </div>

            <h1>
                Think in code.<br>
                Play to <span class="cq-highlight">level up.</span>
            </h1>

            <p class="cq-hero-copy">
                Coding isn't just about getting the answer. It's about solving the puzzle,
                learning the logic, and becoming better with every challenge.
                Your next quest starts here.
            </p>

            <div class="cq-hero-actions">
                <% if (loggedIn) { %>
                    <a class="cq-btn cq-btn-primary" href="<%= dashboardLink %>">
                        Enter your dashboard <span>↗</span>
                    </a>
                <% } else { %>
                    <a class="cq-btn cq-btn-primary" href="<%= registerLink %>">
                        Begin your quest <span>↗</span>
                    </a>
                    <a class="cq-btn cq-btn-outline" href="#features">
                        Explore the arena <span>↓</span>
                    </a>
                <% } %>
            </div>

            <div class="cq-hero-meta">
                <span><b>01</b> &nbsp; BUILD LOGIC</span>
                <span><b>02</b> &nbsp; SOLVE CHALLENGES</span>
                <span><b>03</b> &nbsp; LEVEL UP</span>
            </div>
        </div>

        <div class="cq-console-wrap" aria-label="Decorative code preview">
            <div class="cq-console-glow"></div>

            <div class="cq-float-tag cq-float-one">
                <span class="cq-float-icon">⚡</span>
                <span>
                    <small>PLAYER STATUS</small>
                    <strong>Ready to compile</strong>
                </span>
            </div>

            <div class="cq-console">
                <div class="cq-console-top">
                    <div class="cq-window-dots"><i></i><i></i><i></i></div>
                    <span class="cq-console-title">quest.java — code editor</span>
                    <span class="cq-console-status">● ONLINE</span>
                </div>

                <div class="cq-code-area">
                    <div class="cq-code-line"><span class="cq-line-no">01</span><span class="cq-code-comment">// every great coder starts somewhere</span></div>
                    <div class="cq-code-line"><span class="cq-line-no">02</span><span class="cq-code-key">public class</span>&nbsp;<span class="cq-code-fn">Quest</span> <span class="cq-code-text">{</span></div>
                    <div class="cq-code-line"><span class="cq-line-no">03</span>&nbsp;&nbsp;<span class="cq-code-key">public static void</span> <span class="cq-code-fn">main</span>(String[] args) {</div>
                    <div class="cq-code-line"><span class="cq-line-no">04</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="cq-code-key">int</span> xp = <span class="cq-code-number">0</span>;</div>
                    <div class="cq-code-line"><span class="cq-line-no">05</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="cq-code-key">while</span> (keepLearning) {</div>
                    <div class="cq-code-line"><span class="cq-line-no">06</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;solveChallenge();</div>
                    <div class="cq-code-line"><span class="cq-line-no">07</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xp += <span class="cq-code-number">100</span>;</div>
                    <div class="cq-code-line"><span class="cq-line-no">08</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="cq-code-fn">levelUp</span>();</div>
                    <div class="cq-code-line"><span class="cq-line-no">09</span>&nbsp;&nbsp;&nbsp;&nbsp;}</div>
                    <div class="cq-code-line"><span class="cq-line-no">10</span>&nbsp;&nbsp;&nbsp;&nbsp;System.out.println(<span class="cq-code-string">"Keep going!"</span>);</div>
                    <div class="cq-code-line"><span class="cq-line-no">11</span>&nbsp;&nbsp;} <span class="cq-code-text">}</span><span class="cq-code-cursor"></span></div>
                </div>

                <div class="cq-console-bottom">
                    <div class="cq-mini-stat">
                        <small>MODE</small>
                        <strong>Learn<span>_</span></strong>
                    </div>
                    <div class="cq-mini-stat">
                        <small>DIFFICULTY</small>
                        <strong>Adaptive</strong>
                    </div>
                    <div class="cq-mini-stat">
                        <small>OBJECTIVE</small>
                        <strong>Level up <span>↗</span></strong>
                    </div>
                </div>
            </div>

            <div class="cq-float-tag cq-float-two">
                <span class="cq-float-icon">⌘</span>
                <span>
                    <small>YOUR NEXT MOVE</small>
                    <strong>Think. Debug. Conquer.</strong>
                </span>
            </div>
        </div>
    </section>

    <section class="cq-strip" id="languages">
        <span class="cq-strip-label">Built for curious minds</span>
        <div class="cq-tech-list">
            <span class="cq-tech"><span class="cq-tech-icon">J</span> Java</span>
            <span class="cq-tech"><span class="cq-tech-icon">Py</span> Python</span>
            <span class="cq-tech"><span class="cq-tech-icon">&lt;/&gt;</span> Coding</span>
            <span class="cq-tech"><span class="cq-tech-icon">⌘</span> Logic</span>
            <span class="cq-tech"><span class="cq-tech-icon">♟</span> Strategy</span>
        </div>
    </section>

    <section class="cq-section" id="features">
        <div class="cq-section-head cq-reveal">
            <span class="cq-section-label">// WHY CODEQUEST</span>
            <h2>Less boring practice.<br>More <span>brain power.</span></h2>
            <p>
                Every challenge is an opportunity to sharpen your thinking.
                Build your problem-solving habits, track your progress, and keep moving forward.
            </p>
        </div>

        <div class="cq-feature-grid">
            <article class="cq-feature cq-reveal">
                <span class="cq-feature-index">MODULE_01</span>
                <div class="cq-feature-icon">&lt;/&gt;</div>
                <h3>Challenge your logic</h3>
                <p>Approach programming problems one step at a time and train yourself to think beyond the obvious solution.</p>
            </article>

            <article class="cq-feature cq-reveal">
                <span class="cq-feature-index">MODULE_02</span>
                <div class="cq-feature-icon">⚡</div>
                <h3>Earn your progress</h3>
                <p>Turn consistent practice into a sense of achievement as you build your coding skills and move toward your goals.</p>
            </article>

            <article class="cq-feature cq-reveal">
                <span class="cq-feature-index">MODULE_03</span>
                <div class="cq-feature-icon">♜</div>
                <h3>Think like a strategist</h3>
                <p>Break complex problems into smaller pieces, recognise patterns, and learn to approach solutions methodically.</p>
            </article>
        </div>
    </section>

    <section class="cq-quest-section" id="how-it-works">
        <div class="cq-quest-panel cq-reveal">
            <div>
                <span class="cq-section-label">// PLAYER ONE, YOUR MOVE</span>
                <h2>Your coding journey deserves more than a tutorial tab.</h2>
                <p>
                    Show up, explore problems, make mistakes, and get better.
                    You don't need to know everything before you start.
                    You just need to take the first step.
                </p>
            </div>

            <div class="cq-quest-actions">
                <% if (loggedIn) { %>
                    <a class="cq-btn cq-btn-primary" href="<%= dashboardLink %>">Continue your quest ↗</a>
                <% } else { %>
                    <a class="cq-btn cq-btn-primary" href="<%= registerLink %>">Create your account ↗</a>
                <% } %>
            </div>
        </div>
    </section>
</main>

<footer class="cq-footer">
    <a class="cq-footer-brand" href="<%= contextPath %>/index.jsp">
        <span>&lt;/&gt;</span> codequest
    </a>

    <span>Built for the curious. Powered by persistence.</span>

    <div class="cq-footer-links">
        <a href="#features">Features</a>
        <a href="<%= loginLink %>">Log in</a>
        <a href="<%= registerLink %>">Join CodeQuest</a>
    </div>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const revealItems = document.querySelectorAll('.cq-reveal');
b
        if ('IntersectionObserver' in window) {
            const observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('cq-visible');
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.12 });

            revealItems.forEach(function (item) {
                observer.observe(item);
            });
        } else {
            revealItems.forEach(function (item) {
                item.classList.add('cq-visible');
            });
        }
    });
</script>

</body>
</html>