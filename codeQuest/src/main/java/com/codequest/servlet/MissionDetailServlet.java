package com.codequest.servlet;

import com.codequest.dao.MissionDAO;
import com.codequest.model.Mission;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/mission")
public class MissionDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final MissionDAO missionDAO = new MissionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getSession(false) == null
                || request.getSession(false).getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParameter = request.getParameter("id");

        if (idParameter == null || !idParameter.matches("\\d+")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid mission ID.");
            return;
        }

        try {
            int missionId = Integer.parseInt(idParameter);
            Mission mission = missionDAO.getMissionById(missionId);

            if (mission == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Mission not found.");
                return;
            }

            request.setAttribute("mission", mission);
            request.getRequestDispatcher("/mission-detail.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load the mission.", e);
        }
    }
}

