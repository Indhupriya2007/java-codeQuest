<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codequest.model.Mission" %>

<%
String contextPath = request.getContextPath();

if (session.getAttribute("userId") == null) {
response.sendRedirect(contextPath + "/login.jsp");
return;
}

Object usernameObject = session.getAttribute("username");
String username = usernameObject != null ? usernameObject.toString() : "Player";

Object missionsObject = request.getAttribute("missions");
List<?> missions = missionsObject instanceof List<?> ? (List<?>) missionsObject : null;

String safeUsername = username.replace("&", "&amp;")
.replace("<", "&lt;")
.replace(">", "&gt;")
.replace("\"", "&quot;")
.replace("'", "&#39;");

int missionCount = 0;
if (missions != null) {
for (Object item : missions) {
if (item instanceof Mission) {
missionCount++;
}
}
}
%>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mission Hub | CodeQuest</title>

```
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Space+Grotesk:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --bg: #0c0e12;
        --panel: #14171e;
        --panel-hover: #191d25;
        --line: #282d37;
        --text: #f1f3f7;
        --muted: #9199a8;
        --lime: #c4f36b;
        --cyan: #72e4dc;
        --violet: #b9a0ff;
    }

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        min-height: 100vh;
        background:
            radial-gradient(ellipse at 10% 0%, #b8ee6510, transparent 35%),
            radial-gradient(ellipse at 95% 30%, #8a70ff0b, transparent 30%),
            var(--bg);
        color: var(--text);
        font-family: 'DM Sans', sans-serif;
    }

    a {
        color: inherit;
        text-decoration: none;
    }

    button, a {
        -webkit-tap-highlight-color: transparent;
    }

    .nav {
        min-height: 76px;
        padding: 0 7%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid var(--line);
        background: #0c0e12e8;
    }

    .brand {
        display: flex;
        align-items: center;
        gap: 11px;
        font: 700 22px 'Space Grotesk', sans-serif;
        letter-spacing: -.8px;
    }

    .brand-icon {
        display: grid;
        place-items: center;
        width: 38px;
        height: 38px;
        border-radius: 12px;
        color: #11150a;
        background: var(--lime);
        font-size: 21px;
    }

    .brand > span:last-child span {
        color: var(--lime);
    }

    .nav-right {
        display: flex;
        align-items: center;
        gap: 22px;
        color: var(--muted);
        font-size: 13px;
    }

    .nav-right a:hover,
    .back:hover {
        color: var(--lime);
    }

    .player {
        display: flex;
        align-items: center;
        gap: 9px;
        color: var(--text);
    }

    .avatar {
        display: grid;
        place-items: center;
        width: 32px;
        height: 32px;
        border-radius: 10px;
        background: #c4f36b18;
        border: 1px solid #c4f36b50;
        color: var(--lime);
        font-weight: 700;
    }

    main {
        width: min(1120px, 86%);
        margin: 0 auto;
        padding: 58px 0 80px;
    }

    .back {
        display: inline-flex;
        gap: 9px;
        align-items: center;
        color: var(--muted);
        font-size: 13px;
        margin-bottom: 36px;
        transition: color .2s;
    }

    .eyebrow {
        display: flex;
        align-items: center;
        gap: 9px;
        color: var(--lime);
        text-transform: uppercase;
        letter-spacing: 2px;
        font-size: 11px;
        font-weight: 700;
    }

    .pulse {
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background: var(--lime);
        box-shadow: 0 0 12px #c4f36b80;
    }

    h1 {
        margin: 16px 0 12px;
        font: 700 clamp(35px, 5vw, 54px)/1.1 'Space Grotesk', sans-serif;
        letter-spacing: -2px;
    }

    h1 span {
        color: var(--lime);
    }

    .intro {
        max-width: 570px;
        color: var(--muted);
        line-height: 1.8;
        font-size: 14px;
    }

    .toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 15px;
        margin: 38px 0 20px;
    }

    .section-label {
        font: 600 17px 'Space Grotesk', sans-serif;
    }

    .count {
        padding: 7px 11px;
        border: 1px solid var(--line);
        border-radius: 8px;
        color: var(--muted);
        font-size: 12px;
    }

    .grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 18px;
    }

    .mission {
        position: relative;
        display: flex;
        flex-direction: column;
        min-height: 255px;
        padding: 23px;
        overflow: hidden;
        border: 1px solid var(--line);
        border-radius: 17px;
        background: linear-gradient(145deg, #191d25, #111319);
        transition: transform .2s, border-color .2s, background .2s;
    }

    .mission:hover {
        transform: translateY(-4px);
        border-color: #c4f36b65;
        background: linear-gradient(145deg, #20251e, #14171e);
    }

    .mission::after {
        content: '';
        position: absolute;
        width: 110px;
        height: 110px;
        top: -65px;
        right: -45px;
        background: #c4f36b0b;
        border-radius: 50%;
        pointer-events: none;
    }

    .mission-top {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 10px;
    }

    .mission-icon {
        display: grid;
        place-items: center;
        width: 43px;
        height: 43px;
        border: 1px solid #c4f36b32;
        border-radius: 13px;
        background: #c4f36b0c;
        color: var(--lime);
        font-size: 21px;
    }

    .difficulty {
        padding: 6px 9px;
        border-radius: 6px;
        background: #ffffff08;
        border: 1px solid var(--line);
        color: var(--muted);
        font-size: 10px;
        text-transform: uppercase;
        letter-spacing: .8px;
    }

    .mission h2 {
        margin: 22px 0 9px;
        font: 600 19px 'Space Grotesk', sans-serif;
        overflow-wrap: anywhere;
    }

    .description {
        color: var(--muted);
        font-size: 12px;
        line-height: 1.8;
        flex: 1;
        overflow-wrap: anywhere;
    }

    .mission-bottom {
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 23px;
        padding-top: 16px;
        border-top: 1px solid var(--line);
    }

    .xp {
        color: var(--lime);
        font-size: 12px;
        font-weight: 700;
    }

    .mission-id {
        color: #9199a8;
        font-size: 11px;
    }

    .empty {
        grid-column: 1 / -1;
        padding: 55px 25px;
        text-align: center;
        border: 1px dashed #353b46;
        border-radius: 17px;
        background: #14171e80;
    }

    .empty-icon {
        font-size: 38px;
    }

    .empty h2 {
        margin: 16px 0 9px;
        font: 600 21px 'Space Grotesk', sans-serif;
    }

    .empty p {
        max-width: 450px;
        margin: 0 auto;
        color: var(--muted);
        font-size: 13px;
        line-height: 1.8;
    }

    footer {
        padding: 25px 7%;
        border-top: 1px solid var(--line);
        color: #697181;
        font-size: 12px;
        text-align: center;
    }

    @media (max-width: 850px) {
        .grid {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }

    @media (max-width: 560px) {
        .nav {
            padding: 0 5%;
        }

        .nav-right {
            gap: 12px;
        }

        .nav-right > a:first-child {
            display: none;
        }

        main {
            width: 90%;
            padding-top: 38px;
        }

        .grid {
            grid-template-columns: 1fr;
        }

        .toolbar {
            align-items: flex-start;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        *, *::before, *::after {
            transition: none !important;
            animation: none !important;
        }
    }
</style>
```

</head>

<body>
<header class="nav">
    <a class="brand" href="<%= contextPath %>/index.jsp">
        <span class="brand-icon">⌘</span>
        <span>Code<span>Quest</span></span>
    </a>

```
<div class="nav-right">
    <a href="<%= contextPath %>/dashboard.jsp">Dashboard</a>
    <div class="player">
        <span class="avatar">♟</span>
        <span><%= safeUsername %></span>
    </div>
</div>
```

</header>

<main>
    <a class="back" href="<%= contextPath %>/dashboard.jsp">← Back to dashboard</a>

```
<div class="eyebrow">
    <span class="pulse"></span>
    Mission control · Player active
</div>

<h1>Your next level<br>starts <span>here.</span></h1>

<p class="intro">
    Every challenge is a chance to sharpen your logic, build your coding skills,
    and earn XP. Pick a mission and keep progressing.
</p>

<div class="toolbar">
    <div class="section-label">Available missions</div>
    <div class="count"><%= missionCount %> missions loaded</div>
</div>

<div class="grid">
    <%
    boolean foundMission = false;

    if (missions != null && !missions.isEmpty()) {
        for (Object item : missions) {
            if (!(item instanceof Mission)) {
                continue;
            }

            Mission mission = (Mission) item;
            foundMission = true;

            String missionTitle = mission.getTitle() == null
                    ? "Untitled Mission" : mission.getTitle();

            String missionDescription = mission.getDescription() == null
                    ? "Get ready to test your skills." : mission.getDescription();

            String category = mission.getCategory() == null
                    ? "Coding" : mission.getCategory();

            String difficulty = mission.getDifficulty() == null
                    ? "Standard" : mission.getDifficulty();

            String safeTitle = missionTitle.replace("&", "&amp;")
                    .replace("<", "&lt;").replace(">", "&gt;")
                    .replace("\"", "&quot;").replace("'", "&#39;");

            String safeDescription = missionDescription.replace("&", "&amp;")
                    .replace("<", "&lt;").replace(">", "&gt;")
                    .replace("\"", "&quot;").replace("'", "&#39;");

            String safeCategory = category.replace("&", "&amp;")
                    .replace("<", "&lt;").replace(">", "&gt;")
                    .replace("\"", "&quot;").replace("'", "&#39;");

            String safeDifficulty = difficulty.replace("&", "&amp;")
                    .replace("<", "&lt;").replace(">", "&gt;")
                    .replace("\"", "&quot;").replace("'", "&#39;");
    %>

    <article class="mission">
        <div class="mission-top">
            <div class="mission-icon">⌘</div>
            <span class="difficulty"><%= safeDifficulty %></span>
        </div>

        <h2><%= safeTitle %></h2>

        <div class="description"><%= safeDescription %></div>

        <div class="mission-bottom">
            <span class="xp">⚡ <%= mission.getXpReward() %> XP</span>
            <span class="mission-id"><%= safeCategory %> · #<%= mission.getId() %></span>
        </div>
    </article>

    <%
        }
    }

    if (!foundMission) {
    %>

    <div class="empty">
        <div class="empty-icon">🎮</div>
        <h2>No missions available</h2>
        <p>
            There are no missions to display yet. If you have already added
            missions to MySQL, check that the /missions servlet is loading
            them correctly.
        </p>
    </div>

    <%
    }
    %>
</div>
```

</main>

<footer>CODEQUEST &nbsp;·&nbsp; Play smart. Code better. Level up.</footer>
</body>
</html>
