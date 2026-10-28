package com.codequest.dao;

import com.codequest.model.Mission;
import com.codequest.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MissionDAO {

    public List<Mission> getAllMissions() throws SQLException {

        List<Mission> missions = new ArrayList<>();

        String sql = "SELECT id, title, description, category, difficulty, "
                + "option_a, option_b, option_c, option_d, xp_reward "
                + "FROM missions ORDER BY id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Mission mission = new Mission();

                mission.setId(rs.getInt("id"));
                mission.setTitle(rs.getString("title"));
                mission.setDescription(rs.getString("description"));
                mission.setCategory(rs.getString("category"));
                mission.setDifficulty(rs.getString("difficulty"));
                mission.setOptionA(rs.getString("option_a"));
                mission.setOptionB(rs.getString("option_b"));
                mission.setOptionC(rs.getString("option_c"));
                mission.setOptionD(rs.getString("option_d"));
                mission.setXpReward(rs.getInt("xp_reward"));

                missions.add(mission);
            }
        }

        return missions;
    }

    public Mission getMissionById(int missionId) throws SQLException {

        String sql = "SELECT id, title, description, category, difficulty, "
                + "option_a, option_b, option_c, option_d, correct_answer, "
                + "xp_reward FROM missions WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, missionId);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                Mission mission = new Mission();

                mission.setId(rs.getInt("id"));
                mission.setTitle(rs.getString("title"));
                mission.setDescription(rs.getString("description"));
                mission.setCategory(rs.getString("category"));
                mission.setDifficulty(rs.getString("difficulty"));
                mission.setOptionA(rs.getString("option_a"));
                mission.setOptionB(rs.getString("option_b"));
                mission.setOptionC(rs.getString("option_c"));
                mission.setOptionD(rs.getString("option_d"));
                mission.setCorrectAnswer(rs.getString("correct_answer"));
                mission.setXpReward(rs.getInt("xp_reward"));

                return mission;
            }
        }
    }
}