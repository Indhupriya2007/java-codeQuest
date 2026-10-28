```jsp
<%@ page import="com.codequest.model.Mission" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Mission mission = (Mission) request.getAttribute("mission");

    if (mission == null) {
        response.sendRedirect(request.getContextPath() + "/missions");
        return;
    }

    String[] options = {
        mission.getOptionA(),
        mission.getOptionB(),
        mission.getOptionC(),
        mission.getOptionD()
    };

    String[] labels = {"A", "B", "C", "D"};

    String title = mission.getTitle() == null ? "" : mission.getTitle();
    String description = mission.getDescription() == null ? "" : mission.getDescription();
    String category = mission.getCategory() == null ? "GENERAL" : mission.getCategory();
    String difficulty = mission.getDifficulty() == null ? "BEGINNER" : mission.getDifficulty();

    String safeTitle = title.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    String safeDescription = description.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    String safeCategory = category.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    String safeDifficulty = difficulty.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= safeTitle %> | CodeQuest</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --bg: #101117;
            --panel: #191b25;
            --border: #303240;
            --text: #f2f2fa;
            --muted: #9699ad;
            --accent: #c5f36b;
            --purple: #a99aff;
        }

        body {
            min-height: 100vh;
            background:
                radial-gradient(ellipse at 10% 0%, #25243c 0, transparent 38%),
                var(--bg);
            color: var(--text);
            font-family: "Segoe UI", Arial, sans-serif;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        .topbar {
            height: 76px;
            padding: 0 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #292b36;
            background: rgba(16, 17, 23, 0.9);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 11px;
            font-size: 21px;
            font-weight: 800;
            letter-spacing: -0.7px;
        }

        .brand-icon {
            width: 37px;
            height: 37px;
            display: grid;
            place-items: center;
            border-radius: 12px;
            background: var(--accent);
            color: #171a10;
            font-size: 20px;
        }

        .brand span {
            color: var(--accent);
        }

        .back-link {
            color: #c5c6d2;
            font-size: 13px;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--accent);
        }

        .page {
            width: min(850px, 90%);
            margin: 52px auto 80px;
        }

        .eyebrow {
            display: flex;
            align-items: center;
            gap: 9px;
            color: var(--accent);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .eyebrow-mark {
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: var(--accent);
            box-shadow: 0 0 12px #c5f36b80;
        }

        h1 {
            margin-top: 17px;
            font-size: clamp(30px, 5vw, 45px);
            letter-spacing: -1.8px;
            line-height: 1.12;
            overflow-wrap: anywhere;
        }

        .subtitle {
            margin-top: 14px;
            max-width: 650px;
            color: var(--muted);
            font-size: 15px;
            line-height: 1.8;
            overflow-wrap: anywhere;
        }

        .tags {
            display: flex;
            flex-wrap: wrap;
            gap: 9px;
            margin-top: 22px;
        }

        .tag {
            padding: 8px 12px;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: #1b1d28;
            color: #c5c6d5;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.6px;
        }

        .xp-tag {
            border-color: #b5e95b45;
            color: var(--accent);
            background: #c5f36b0b;
        }

        .challenge {
            margin-top: 35px;
            padding: 30px;
            border: 1px solid var(--border);
            border-radius: 19px;
            background: linear-gradient(145deg, #1c1e29, #171820);
            box-shadow: 0 20px 65px #00000025;
        }

        .challenge-heading {
            display: flex;
            align-items: center;
            gap: 13px;
            margin-bottom: 12px;
        }

        .challenge-icon {
            width: 43px;
            height: 43px;
            display: grid;
            place-items: center;
            border: 1px solid #a99aff40;
            border-radius: 13px;
            background: #a99aff12;
            color: var(--purple);
            font-size: 21px;
        }

        .challenge-heading h2 {
            font-size: 19px;
            letter-spacing: -0.4px;
        }

        .challenge-heading p {
            margin-top: 5px;
            color: var(--muted);
            font-size: 12px;
        }

        .instruction {
            margin: 23px 0 25px;
            padding: 17px;
            border-left: 3px solid var(--purple);
            border-radius: 0 9px 9px 0;
            background: #a99aff0b;
            color: #c9c9d8;
            font-size: 14px;
            line-height: 1.8;
            overflow-wrap: anywhere;
        }

        .section-label {
            margin-bottom: 14px;
            color: #e6e6ef;
            font-size: 13px;
            font-weight: 700;
        }

        .options {
            display: grid;
            gap: 11px;
        }

        .option {
            position: relative;
        }

        .option input {
            position: absolute;
            opacity: 0;
            pointer-events: none;
        }

        .option label {
            display: flex;
            align-items: center;
            gap: 14px;
            min-height: 62px;
            padding: 13px 16px;
            border: 1px solid #343643;
            border-radius: 11px;
            background: #15161e;
            color: #d6d6e2;
            cursor: pointer;
            transition: border-color 0.2s, background 0.2s, transform 0.2s;
        }

        .option label:hover {
            border-color: #77718f;
            transform: translateY(-1px);
        }

        .option-letter {
            flex: 0 0 34px;
            width: 34px;
            height: 34px;
            display: grid;
            place-items: center;
            border: 1px solid #3a3c4b;
            border-radius: 9px;
            color: #aeb0c3;
            font-size: 12px;
            font-weight: 800;
        }

        .option-text {
            font-size: 13px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .option input:checked + label {
            border-color: var(--accent);
            background: #c5f36b0b;
            color: #fff;
        }

        .option input:checked + label .option-letter {
            border-color: var(--accent);
            background: var(--accent);
            color: #171a10;
        }

        .option input:focus-visible + label {
            outline: 2px solid var(--purple);
            outline-offset: 3px;
        }

        .submit-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            margin-top: 28px;
            padding-top: 22px;
            border-top: 1px solid #30313d;
        }

        .submit-note {
            color: var(--muted);
            font-size: 11px;
            line-height: 1.7;
        }

        .submit-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 48px;
            padding: 0 22px;
            border: none;
            border-radius: 10px;
            background: var(--accent);
            color: #171a10;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px #c5f36b20;
        }

        @media (max-width: 600px) {
            .topbar {
                height: 68px;
                padding: 0 5%;
            }

            .page {
                margin-top: 35px;
            }

            .challenge {
                padding: 20px 16px;
            }

            .submit-row {
                align-items: stretch;
                flex-direction: column;
            }

            .submit-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<header class="topbar">
    <a class="brand" href="<%= request.getContextPath() %>/dashboard.jsp">
        <div class="brand-icon">⌘</div>
        <div>CODE<span>QUEST</span></div>
    </a>

    <a class="back-link" href="<%= request.getContextPath() %>/missions">
        ← All missions
    </a>
</header>

<main class="page">
    <div class="eyebrow">
        <span class="eyebrow-mark"></span>
        Active mission
    </div>

    <h1><%= safeTitle %></h1>

    <p class="subtitle">
        Every challenge earns you experience. Think carefully, choose your answer,
        and prove your skills.
    </p>

    <div class="tags">
        <span class="tag"><%= safeCategory %></span>
        <span class="tag"><%= safeDifficulty %></span>
        <span class="tag xp-tag">✦ <%= mission.getXpReward() %> XP REWARD</span>
    </div>

    <section class="challenge">
        <div class="challenge-heading">
            <div class="challenge-icon">⚔</div>
            <div>
                <h2>Your Challenge</h2>
                <p>Read the mission brief before choosing an answer.</p>
            </div>
        </div>

        <div class="instruction"><%= safeDescription %></div>

        <form action="<%= request.getContextPath() %>/submit-answer" method="post">
            <input type="hidden" name="missionId" value="<%= mission.getId() %>">

            <p class="section-label">Select your answer</p>

            <div class="options">
                <% for (int i = 0; i < options.length; i++) {
                    String option = options[i] == null ? "" : options[i];
                    String safeOption = option.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
                %>
                    <div class="option">
                        <input
                            type="radio"
                            id="option<%= labels[i] %>"
                            name="answer"
                            value="<%= labels[i] %>"
                            required
                        >
                        <label for="option<%= labels[i] %>">
                            <span class="option-letter"><%= labels[i] %></span>
                            <span class="option-text"><%= safeOption.isBlank() ? "Option not configured" : safeOption %></span>
                        </label>
                    </div>
                <% } %>
            </div>

            <div class="submit-row">
                <p class="submit-note">
                    ⚡ Choose carefully.<br>
                    Your XP is awarded after answer verification.
                </p>

                <button class="submit-btn" type="submit">
                    Submit Answer <span>→</span>
                </button>
            </div>
        </form>
    </section>
</main>

</body>
</html>
```
