/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long0
 */
public class AttemptID {
    private int attemptID;
    private int userID;
    private int quizID;
    private String startTime;
    private String endTime;
    private double totalScore;

    public AttemptID() {
    }

    public AttemptID(int attemptID, int userID, int quizID, String startTime, String endTime, double totalScore) {
        this.attemptID = attemptID;
        this.userID = userID;
        this.quizID = quizID;
        this.startTime = startTime;
        this.endTime = endTime;
        this.totalScore = totalScore;
    }

    public int getAttemptID() {
        return attemptID;
    }

    public void setAttemptID(int attemptID) {
        this.attemptID = attemptID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }
    
    
}
