package com.codequest.service;

import com.codequest.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class XPService {

    public boolean awardXP(int userId, int xp) throws SQLException {

        if (userId <= 0 || xp <= 0) {
            return false;
        }

        String sql = "UPDATE users SET "
                + "player_level = ((total_xp + ?) DIV 100) + 1, "
                + "total_xp = total_xp + ? "
                + "WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

        	ps.setInt(1, xp);
        	ps.setInt(2, xp);
        	ps.setInt(3, userId);

            return ps.executeUpdate() == 1;
        }
    }

    public int getTotalXP(int userId) throws SQLException {

        String sql = "SELECT total_xp FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("total_xp") : 0;
            }
        }
    }

    public int getPlayerLevel(int userId) throws SQLException {

        String sql = "SELECT player_level FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt("player_level") : 1;
            }
        }
    }
}
