package com.codequest.servlet;

import com.codequest.util.DBConnection;
import com.codequest.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Missing authentication action.");
            return;
        }

        try {
            switch (action) {
                case "register":
                    register(request, response);
                    break;

                case "login":
                    login(request, response);
                    break;

                case "logout":
                    logout(request, response);
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid authentication action.");
            }
        } catch (SQLException e) {
            throw new ServletException("Authentication database error.", e);
        }
    }

    private void register(HttpServletRequest request,
                          HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null
                || username.isBlank() || email.isBlank()
                || password.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "All registration fields are required.");
            return;
        }

        username = username.trim();
        email = email.trim();

        if (username.length() > 50 || email.length() > 100
                || password.length() > 256
                || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Please check your registration details.");
            return;
        }

        if (password.length() < 8) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Password must contain at least 8 characters.");
            return;
        }

        String sql = "INSERT INTO users "
                + "(username, email, password, total_xp, player_level) "
                + "VALUES (?, ?, ?, 0, 1)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, PasswordUtil.hashPassword(password));

            if (ps.executeUpdate() == 1) {
                response.sendRedirect(
                        request.getContextPath() + "/login.jsp?registered=1");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Registration failed.");
            }

        } catch (SQLException e) {
            if ("23000".equals(e.getSQLState())) {
                response.sendError(HttpServletResponse.SC_CONFLICT,
                        "Username or email already exists.");
            } else {
                throw e;
            }
        }
    }

    private void login(HttpServletRequest request,
                       HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null
                || username.isBlank() || password.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Username and password are required.");
            return;
        }

        String sql = "SELECT id, username, password, total_xp, player_level "
                + "FROM users WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username.trim());

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()
                        && PasswordUtil.verifyPassword(
                                password, rs.getString("password"))) {

                    HttpSession oldSession = request.getSession(false);

                    if (oldSession != null) {
                        oldSession.invalidate();
                    }

                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("totalXP", rs.getInt("total_xp"));
                    session.setAttribute("playerLevel",
                            rs.getInt("player_level"));

                    session.setMaxInactiveInterval(30 * 60);

                    response.sendRedirect(
                            request.getContextPath() + "/dashboard.jsp");

                } else {
                    response.sendRedirect(
                            request.getContextPath()
                            + "/login.jsp?error=invalid");
                }
            }
        }
    }

    private void logout(HttpServletRequest request,
                        HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(
                request.getContextPath() + "/login.jsp?logout=1");
    }
}