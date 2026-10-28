<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String contextPath = request.getContextPath();

    if (session.getAttribute("userId") == null) {
        response.sendRedirect(contextPath + "/login.jsp");
        return;
    }

    Object usernameObject = session.getAttribute("username");
    String username = usernameObject != null ? usernameObject.toString() : "Player";
    int totalXP = session.getAttribute("totalXP") instanceof Number
    	    ? ((Number) session.getAttribute("totalXP")).intValue() : 0;

    	int playerLevel = session.getAttribute("playerLevel") instanceof Number
    	    ? ((Number) session.getAttribute("playerLevel")).intValue() : 1;

    	int currentLevelXP = totalXP % 100;
    	int xpToNextLevel = 100 - currentLevelXP;
    String safeUsername = username
        .replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace("\"", "&quot;")
        .replace("'", "&#39;");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Player Dashboard — CodeQuest</title>
    <meta name="description" content="Your CodeQuest player dashboard.">
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/style.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            background: #0b0c0a;
            color: #f0f0e8;
            font-family: 'Manrope', sans-serif;
            min-height: 100vh;
        }

        a { color: inherit; text-decoration: none; }
        button { font: inherit; }

        .db-nav {
            min-height: 72px;
            padding: 0 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            border-bottom: 1px solid rgba(240,240,232,.09);
            background: rgba(11,12,10,.9);
            backdrop-filter: blur(18px);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .db-brand {
            display: flex;
            align-items: center;
            gap: 11px;
            font-size: 19px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .db-logo {
            width: 36px;
            height: 36px;
            display: grid;
            place-items: center;
            border-radius: 9px;
            background: #d7ff64;
            color: #15190b;
            font: 17px 'DM Mono', monospace;
        }

        .db-brand span span { color: #d7ff64; }

        .db-nav-right {
            display: flex;
            align-items: center;
            gap: 19px;
        }

        .db-status {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #8e9583;
            font: 10px 'DM Mono', monospace;
            letter-spacing: .5px;
        }

        .db-status-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #a8ff91;
            box-shadow: 0 0 10px rgba(168,255,145,.6);
        }

        .db-user {
            display: flex;
            align-items: center;
            gap: 10px;
            padding-left: 18px;
            border-left: 1px solid rgba(240,240,232,.12);
        }

        .db-avatar {
            width: 34px;
            height: 34px;
            display: grid;
            place-items: center;
            border-radius: 8px;
            background: rgba(215,255,100,.09);
            border: 1px solid rgba(215,255,100,.22);
            color: #d7ff64;
            font: 14px 'DM Mono', monospace;
        }

        .db-user-name {
            max-width: 140px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 11px;
            font-weight: 800;
        }

        .db-logout {
            padding: 10px 13px;
            color: #9a9e91;
            font-size: 11px;
            font-weight: 700;
            border: 1px solid rgba(240,240,232,.12);
            border-radius: 6px;
            background: transparent;
            transition: .2s ease;
        }

        .db-logout:hover {
            color: #ff9188;
            border-color: rgba(255,120,111,.35);
            background: rgba(255,120,111,.04);
        }

        .db-layout {
            max-width: 1440px;
            margin: 0 auto;
            padding: 42px 5% 70px;
        }

        .db-breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
            color: #72786b;
            font: 10px 'DM Mono', monospace;
        }

        .db-breadcrumb span:last-child { color: #d7ff64; }

        .db-welcome {
            position: relative;
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 25px;
            align-items: center;
            padding: 36px 38px;
            border: 1px solid rgba(240,240,232,.11);
            border-radius: 11px;
            background:
                radial-gradient(ellipse at 95% 0%, rgba(113,232,255,.08), transparent 35%),
                radial-gradient(ellipse at 55% 110%, rgba(181,160,255,.045), transparent 45%),
                linear-gradient(110deg, rgba(215,255,100,.045), rgba(255,255,255,.012));
            overflow: hidden;
        }

        .db-welcome::after {
            content: "</>";
            position: absolute;
            right: 18%;
            top: -55px;
            color: rgba(240,240,232,.025);
            font: 150px 'DM Mono', monospace;
            pointer-events: none;
        }

        .db-welcome-content, .db-player-badge {
            position: relative;
            z-index: 1;
        }

        .db-eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            color: #d7ff64;
            font: 10px 'DM Mono', monospace;
            letter-spacing: 1.4px;
            text-transform: uppercase;
        }

        .db-welcome h1 {
            margin: 17px 0 12px;
            font-size: clamp(30px, 4vw, 45px);
            line-height: 1.15;
            letter-spacing: -2px;
        }

        .db-welcome h1 span { color: #d7ff64; }

        .db-welcome p {
            max-width: 570px;
            margin: 0;
            color: #969b8d;
            font-size: 12px;
            line-height: 1.9;
        }

        .db-player-badge {
            min-width: 160px;
            text-align: center;
            padding: 21px;
            border: 1px solid rgba(215,255,100,.17);
            border-radius: 9px;
            background: rgba(11,12,10,.45);
        }

        .db-player-symbol {
            width: 50px;
            height: 50px;
            display: grid;
            place-items: center;
            margin: 0 auto 13px;
            color: #d7ff64;
            border: 1px solid rgba(215,255,100,.22);
            background: rgba(215,255,100,.07);
            border-radius: 13px;
            font: 22px 'DM Mono', monospace;
        }

        .db-player-badge small {
            display: block;
            color: #7e8574;
            font: 9px 'DM Mono', monospace;
            margin-bottom: 7px;
        }

        .db-player-badge strong {
            font-size: 14px;
            letter-spacing: .3px;
        }

        .db-section-heading {
            margin: 39px 0 19px;
            display: flex;
            align-items: end;
            justify-content: space-between;
            gap: 15px;
        }

        .db-section-heading h2 {
            margin: 0;
            font-size: 17px;
            letter-spacing: -.5px;
        }

        .db-section-heading p {
            margin: 7px 0 0;
            color: #858b7b;
            font-size: 11px;
            line-height: 1.7;
        }

        .db-section-code {
            color: #6c7363;
            font: 9px 'DM Mono', monospace;
            letter-spacing: 1px;
        }

        .db-stats {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 15px;
        }

        .db-stat {
            position: relative;
            padding: 22px;
            min-height: 145px;
            border: 1px solid rgba(240,240,232,.1);
            border-radius: 9px;
            background: linear-gradient(145deg, rgba(255,255,255,.027), rgba(255,255,255,.006));
            transition: border-color .2s ease, transform .2s ease;
        }

        .db-stat:hover {
            transform: translateY(-3px);
            border-color: rgba(215,255,100,.24);
        }

        .db-stat-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }

        .db-stat-label {
            color: #8c9283;
            font-size: 10px;
            font-weight: 700;
        }

        .db-stat-icon {
            width: 33px;
            height: 33px;
            display: grid;
            place-items: center;
            border-radius: 7px;
            color: #d7ff64;
            background: rgba(215,255,100,.07);
            border: 1px solid rgba(215,255,100,.12);
            font: 13px 'DM Mono', monospace;
        }

        .db-stat:nth-child(2) .db-stat-icon {
            color: #71e8ff;
            background: rgba(113,232,255,.05);
            border-color: rgba(113,232,255,.14);
        }

        .db-stat:nth-child(3) .db-stat-icon {
            color: #b5a0ff;
            background: rgba(181,160,255,.05);
            border-color: rgba(181,160,255,.14);
        }

        .db-stat:nth-child(4) .db-stat-icon {
            color: #ffb68b;
            background: rgba(255,182,139,.05);
            border-color: rgba(255,182,139,.14);
        }

        .db-stat-value {
            margin-top: 19px;
            font-size: 30px;
            line-height: 1;
            font-weight: 800;
            letter-spacing: -1.2px;
        }

        .db-stat-value small {
            font-size: 11px;
            color: #9aa08d;
            font-weight: 600;
            letter-spacing: 0;
        }

        .db-stat-note {
            margin-top: 10px;
            color: #747b6b;
            font: 9px 'DM Mono', monospace;
        }

        .db-main-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.45fr) minmax(270px, .75fr);
            gap: 18px;
            align-items: start;
        }

        .db-panel {
            border: 1px solid rgba(240,240,232,.1);
            border-radius: 9px;
            background: rgba(255,255,255,.015);
            overflow: hidden;
        }

        .db-panel-head {
            padding: 20px 23px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid rgba(240,240,232,.08);
        }

        .db-panel-head h3 {
            margin: 0;
            font-size: 13px;
            letter-spacing: -.2px;
        }

        .db-panel-head small {
            color: #7f8676;
            font: 9px 'DM Mono', monospace;
        }

        .db-panel-body { padding: 22px; }

        .db-quest-list {
            display: grid;
            gap: 12px;
        }

        .db-quest {
            display: grid;
            grid-template-columns: 45px minmax(0, 1fr) auto;
            align-items: center;
            gap: 14px;
            padding: 17px;
            border: 1px solid rgba(240,240,232,.08);
            border-radius: 8px;
            background: rgba(255,255,255,.012);
            transition: border-color .2s ease, background .2s ease;
        }

        .db-quest:hover {
            border-color: rgba(215,255,100,.22);
            background: rgba(215,255,100,.018);
        }

        .db-quest-icon {
            width: 44px;
            height: 44px;
            display: grid;
            place-items: center;
            border: 1px solid rgba(215,255,100,.17);
            border-radius: 9px;
            color: #d7ff64;
            background: rgba(215,255,100,.06);
            font: 17px 'DM Mono', monospace;
        }

        .db-quest:nth-child(2) .db-quest-icon {
            color: #71e8ff;
            border-color: rgba(113,232,255,.16);
            background: rgba(113,232,255,.05);
        }

        .db-quest:nth-child(3) .db-quest-icon {
            color: #b5a0ff;
            border-color: rgba(181,160,255,.16);
            background: rgba(181,160,255,.05);
        }

        .db-quest-info h4 {
            margin: 0 0 6px;
            font-size: 12px;
        }

        .db-quest-info p {
            margin: 0;
            color: #858b7c;
            font-size: 10px;
            line-height: 1.7;
        }

        .db-quest-tag {
            display: inline-flex;
            margin-top: 8px;
            padding: 4px 7px;
            border-radius: 4px;
            background: rgba(255,255,255,.04);
            color: #929889;
            font: 8px 'DM Mono', monospace;
        }

        .db-quest-arrow {
            color: #8a9081;
            font-size: 16px;
            transition: color .2s ease, transform .2s ease;
        }

        .db-quest:hover .db-quest-arrow {
            color: #d7ff64;
            transform: translateX(3px);
        }

        .db-side-stack {
            display: grid;
            gap: 18px;
        }

        .db-progress-card {
            padding: 23px;
            border: 1px solid rgba(215,255,100,.16);
            border-radius: 9px;
            background:
                radial-gradient(ellipse at 100% 0%, rgba(113,232,255,.05), transparent 50%),
                rgba(215,255,100,.018);
        }

        .db-progress-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
        }

        .db-progress-top small {
            color: #909686;
            font: 9px 'DM Mono', monospace;
        }

        .db-level {
            color: #d7ff64;
            font-size: 27px;
            font-weight: 800;
            letter-spacing: -1px;
            margin: 16px 0 5px;
        }

        .db-level-caption {
            color: #8b9280;
            font-size: 10px;
        }

        .db-progress-track {
            height: 5px;
            background: rgba(240,240,232,.09);
            border-radius: 10px;
            overflow: hidden;
            margin: 20px 0 10px;
        }

        .db-progress-fill {
            width: 35%;
            height: 100%;
            background: linear-gradient(90deg, #d7ff64, #71e8ff);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(215,255,100,.18);
        }

        .db-progress-footer {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            color: #7e8574;
            font: 9px 'DM Mono', monospace;
        }

        .db-shortcuts {
            display: grid;
            gap: 9px;
        }

        .db-shortcut {
            display: flex;
            align-items: center;
            gap: 12px;
            width: 100%;
            padding: 13px;
            border: 1px solid rgba(240,240,232,.09);
            border-radius: 7px;
            background: rgba(255,255,255,.015);
            text-align: left;
            cursor: pointer;
            color: #e7e9de;
            transition: border-color .2s ease, background .2s ease, transform .2s ease;
        }

        .db-shortcut:hover {
            transform: translateX(3px);
            border-color: rgba(215,255,100,.25);
            background: rgba(215,255,100,.025);
        }

        .db-shortcut-icon {
            width: 32px;
            height: 32px;
            display: grid;
            place-items: center;
            color: #d7ff64;
            background: rgba(215,255,100,.06);
            border-radius: 6px;
            font: 12px 'DM Mono', monospace;
        }

        .db-shortcut:nth-child(2) .db-shortcut-icon { color: #71e8ff; }
        .db-shortcut:nth-child(3) .db-shortcut-icon { color: #b5a0ff; }

        .db-shortcut-label { flex: 1; }

        .db-shortcut-label strong {
            display: block;
            font-size: 10px;
            margin-bottom: 4px;
        }

        .db-shortcut-label small {
            display: block;
            color: #858b7b;
            font-size: 9px;
        }

        .db-shortcut-arrow {
            color: #747b6b;
            font-size: 13px;
        }

        .db-tip {
            padding: 18px;
            border-left: 2px solid #71e8ff;
            background: rgba(113,232,255,.035);
        }

        .db-tip-label {
            color: #71e8ff;
            font: 9px 'DM Mono', monospace;
            letter-spacing: 1px;
        }

        .db-tip p {
            margin: 10px 0 0;
            color: #a0a596;
            font-size: 11px;
            line-height: 1.9;
        }

        .db-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 48px;
            padding-top: 23px;
            border-top: 1px solid rgba(240,240,232,.08);
            color: #6e7565;
            font: 9px 'DM Mono', monospace;
        }

        .db-footer a:hover { color: #d7ff64; }

        .db-toast {
            position: fixed;
            z-index: 200;
            bottom: 24px;
            right: 24px;
            max-width: calc(100vw - 40px);
            padding: 15px 18px;
            border: 1px solid rgba(215,255,100,.24);
            border-radius: 8px;
            background: #171a13;
            color: #e9ecdf;
            font-size: 11px;
            box-shadow: 0 15px 45px rgba(0,0,0,.4);
            opacity: 0;
            transform: translateY(10px);
            pointer-events: none;
            transition: opacity .25s ease, transform .25s ease;
        }

        .db-toast.db-toast-visible {
            opacity: 1;
            transform: translateY(0);
        }

        @media (max-width: 1000px) {
            .db-layout { padding-left: 4%; padding-right: 4%; }
            .db-stats { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .db-main-grid { grid-template-columns: 1fr; }
            .db-side-stack { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .db-side-stack .db-tip { grid-column: 1 / -1; }
        }

        @media (max-width: 650px) {
            .db-nav { padding: 0 5%; min-height: 66px; }
            .db-status { display: none; }
            .db-nav-right { gap: 12px; }
            .db-user { padding-left: 12px; }
            .db-user-name { max-width: 85px; }
            .db-logout { padding: 9px; font-size: 10px; }
            .db-layout { padding-top: 27px; }
            .db-welcome { grid-template-columns: 1fr; padding: 27px 23px; }
            .db-welcome h1 { letter-spacing: -1.4px; }
            .db-player-badge { display: flex; align-items: center; gap: 13px; text-align: left; padding: 13px; }
            .db-player-symbol { width: 39px; height: 39px; margin: 0; font-size: 17px; }
            .db-player-badge small { margin-bottom: 4px; }
            .db-player-badge strong { font-size: 12px; }
            .db-section-heading { align-items: start; }
            .db-section-code { display: none; }
            .db-stat { padding: 17px; min-height: 135px; }
            .db-stat-value { font-size: 26px; }
            .db-panel-head { padding: 17px; }
            .db-panel-body { padding: 14px; }
            .db-quest { grid-template-columns: 39px minmax(0, 1fr) auto; gap: 10px; padding: 13px 10px; }
            .db-quest-icon { width: 37px; height: 37px; }
            .db-quest-info h4 { font-size: 11px; }
            .db-quest-info p { font-size: 9px; }
            .db-side-stack { grid-template-columns: 1fr; }
            .db-side-stack .db-tip { grid-column: auto; }
            .db-footer { margin-top: 32px; }
        }

        @media (max-width: 390px) {
            .db-brand { font-size: 16px; }
            .db-logo { width: 31px; height: 31px; }
            .db-user { gap: 7px; }
            .db-avatar { width: 29px; height: 29px; }
            .db-user-name { max-width: 62px; font-size: 10px; }
            .db-stats { gap: 10px; }
            .db-stat { padding: 13px; }
            .db-stat-label { font-size: 9px; }
            .db-stat-icon { width: 29px; height: 29px; }
            .db-stat-value { font-size: 23px; }
            .db-quest { grid-template-columns: 33px minmax(0, 1fr) auto; gap: 8px; }
            .db-quest-icon { width: 32px; height: 32px; font-size: 13px; }
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after {
                animation-duration: .01ms !important;
                transition-duration: .01ms !important;
            }
        }
    </style>
</head>
<body>

<header class="db-nav">
    <a class="db-brand" href="<%= contextPath %>/index.jsp">
        <span class="db-logo">&lt;/&gt;</span>
        <span>code<span>quest</span></span>
    </a>

    <div class="db-nav-right">
        <div class="db-status">
            <span class="db-status-dot"></span>
            PLAYER SESSION ACTIVE
        </div>

        <div class="db-user">
            <span class="db-avatar" aria-hidden="true">♟</span>
            <span class="db-user-name"><%= safeUsername %></span>
        </div>

        <form action="<%= contextPath %>/auth" method="post" style="margin:0;">
            <input type="hidden" name="action" value="logout">
            <button class="db-logout" type="submit">Log out ↗</button>
        </form>
    </div>
</header>

<main class="db-layout">
    <div class="db-breadcrumb">
        <a href="<%= contextPath %>/index.jsp">HOME</a>
        <span>/</span>
        <span>PLAYER DASHBOARD</span>
    </div>

    <section class="db-welcome">
        <div class="db-welcome-content">
            <div class="db-eyebrow">
                <span class="db-status-dot"></span>
                WELCOME BACK, PLAYER
            </div>

            <h1>Ready to level up,<br><span><%= safeUsername %></span>?</h1>

            <p>
                Your next breakthrough could be one problem away.
                Explore your coding quests, sharpen your logic, and keep building your skills.
                Every great developer starts with the next step.
            </p>
        </div>

        <div class="db-player-badge">
            <span class="db-player-symbol">♜</span>
            <span>
                <small>PLAYER CLASS</small>
                <strong>Code Explorer</strong>
            </span>
        </div>
    </section>

    <div class="db-section-heading">
        <div>
            <h2>Your player overview</h2>
            <p>A quick look at your coding journey.</p>
        </div>
        <span class="db-section-code">PLAYER_STATS // 001</span>
    </div>

    <section class="db-stats" aria-label="Player statistics">
        <article class="db-stat">
            <div class="db-stat-top">
                <span class="db-stat-label">Total XP</span>
                <span class="db-stat-icon">⚡</span>
            </div>
            <div class="db-stat-value"><%= totalXP %> <small>XP</small></div>
            <div class="db-stat-note">YOUR JOURNEY STARTS HERE</div>
        </article>

        <article class="db-stat">
            <div class="db-stat-top">
                <span class="db-stat-label">Player Level</span>
                <span class="db-stat-icon">♜</span>
            </div>
            <div class="db-stat-value"><%= String.format("%02d", playerLevel) %></div>
            <div class="db-stat-note">CODE EXPLORER</div>
        </article>

        <article class="db-stat">
            <div class="db-stat-top">
                <span class="db-stat-label">Challenges</span>
                <span class="db-stat-icon">&lt;/&gt;</span>
            </div>
            <div class="db-stat-value">0</div>
            <div class="db-stat-note">READY FOR YOUR FIRST QUEST</div>
        </article>

        <article class="db-stat">
            <div class="db-stat-top">
                <span class="db-stat-label">Achievements</span>
                <span class="db-stat-icon">✦</span>
            </div>
            <div class="db-stat-value">0</div>
            <div class="db-stat-note">YOUR FIRST ONE AWAITS</div>
        </article>
    </section>

    <div class="db-section-heading">
        <div>
            <h2>Choose your next move</h2>
            <p>Every skill begins with a challenge.</p>
        </div>
        <span class="db-section-code">QUEST_BOARD // 002</span>
    </div>

    <div class="db-main-grid">
        <section class="db-panel">
            <div class="db-panel-head">
                <h3>Available quests</h3>
                <small>SELECT YOUR PATH</small>
            </div>

            <div class="db-panel-body">
                <div class="db-quest-list">
                    <article class="db-quest">
                        <div class="db-quest-icon">&lt;/&gt;</div>
                        <div class="db-quest-info">
                            <h4>Logic Initiation</h4>
                            <p>Start with the fundamentals. Learn to break a problem into smaller, manageable steps.</p>
                            <span class="db-quest-tag">BEGINNER · LOGIC</span>
                        </div>
                        <span class="db-quest-arrow" aria-hidden="true">↗</span>
                    </article>

                    <article class="db-quest">
                        <div class="db-quest-icon">J</div>
                        <div class="db-quest-info">
                            <h4>Java Awakening</h4>
                            <p>Explore the building blocks of Java and strengthen your programming foundations.</p>
                            <span class="db-quest-tag">JAVA · FUNDAMENTALS</span>
                        </div>
                        <span class="db-quest-arrow" aria-hidden="true">↗</span>
                    </article>

                    <article class="db-quest">
                        <div class="db-quest-icon">♟</div>
                        <div class="db-quest-info">
                            <h4>Pattern Hunter</h4>
                            <p>Train your problem-solving instincts by spotting patterns and thinking strategically.</p>
                            <span class="db-quest-tag">PROBLEM SOLVING</span>
                        </div>
                        <span class="db-quest-arrow" aria-hidden="true">↗</span>
                    </article>
                </div>
            </div>
        </section>

        <aside class="db-side-stack">
            <section class="db-progress-card">
                <div class="db-progress-top">
                    <small>PLAYER PROGRESSION</small>
                    <span class="db-stat-icon">⚡</span>
                </div>

                <div class="db-level">Level <%= String.format("%02d", playerLevel) %></div>
                <div class="db-level-caption"><%= xpToNextLevel %> XP to the next level</div>
                <div class="db-progress-track">
                   <div class="db-progress-fill" style="width: <%= currentLevelXP %>%;"></div>
                </div>

                <div class="db-progress-footer">
                    <span>LEVEL 01</span>
                    <span>PROGRESS PREVIEW</span>
                </div>
            </section>

            <section class="db-panel">
                <div class="db-panel-head">
                    <h3>Quick access</h3>
                    <small>SHORTCUTS</small>
                </div>

                <div class="db-panel-body">
                    <div class="db-shortcuts">
                        <button type="button" class="db-shortcut" data-message="The coding challenge module will be connected here.">
                            <span class="db-shortcut-icon">&lt;/&gt;</span>
                            <span class="db-shortcut-label">
                                <strong>Coding Arena</strong>
                                <small>Practice your logic</small>
                            </span>
                            <span class="db-shortcut-arrow">↗</span>
                        </button>

                        <button type="button" class="db-shortcut" data-message="Your achievements module will be connected here.">
                            <span class="db-shortcut-icon">✦</span>
                            <span class="db-shortcut-label">
                                <strong>Achievements</strong>
                                <small>Track your milestones</small>
                            </span>
                            <span class="db-shortcut-arrow">↗</span>
                        </button>

                        <button type="button" class="db-shortcut" data-message="Your player statistics module will be connected here.">
                            <span class="db-shortcut-icon">⌘</span>
                            <span class="db-shortcut-label">
                                <strong>Player stats</strong>
                                <small>Review your progress</small>
                            </span>
                            <span class="db-shortcut-arrow">↗</span>
                        </button>
                    </div>
                </div>
            </section>

            <section class="db-tip">
                <span class="db-tip-label">✦ QUEST TIP // 001</span>
                <p>
                    Don't chase perfect code on your first attempt.
                    Understand the problem, build a plan, test your idea, and improve it.
                    Progress beats perfection.
                </p>
            </section>
        </aside>
    </div>

    <footer class="db-footer">
        <span>CODEQUEST // KEEP THINKING. KEEP BUILDING.</span>
        <a href="<%= contextPath %>/index.jsp">← Back to home</a>
    </footer>
</main>

<div class="db-toast" id="dashboardToast" role="status" aria-live="polite"></div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const toast = document.getElementById('dashboardToast');
        let toastTimer;

        document.querySelectorAll('[data-message]').forEach(function (button) {
            button.addEventListener('click', function () {
                toast.textContent = button.getAttribute('data-message');
                toast.classList.add('db-toast-visible');

                clearTimeout(toastTimer);
                toastTimer = setTimeout(function () {
                    toast.classList.remove('db-toast-visible');
                }, 3000);
            });
        });
    });
</script>

</body>
</html>