/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Quiz {
    private int quizID;
    private int sectionID;
    private String quizName;
    private double passRate;
    private String quizType;
    private int quizDuration;
    private String quizLevel;
    private boolean status;

    public Quiz() {
    }

    public Quiz(int quizID, int sectionID, String quizName, double passRate, String quizType, int quizDuration, String quizLevel, boolean status) {
        this.quizID = quizID;
        this.sectionID = sectionID;
        this.quizName = quizName;
        this.passRate = passRate;
        this.quizType = quizType;
        this.quizDuration = quizDuration;
        this.quizLevel = quizLevel;
        this.status = status;
    }

    public int getQuizID() {
        return quizID;
    }

    public void setQuizID(int quizID) {
        this.quizID = quizID;
    }

    public int getSectionID() {
        return sectionID;
    }

    public void setSectionID(int sectionID) {
        this.sectionID = sectionID;
    }

    public String getQuizName() {
        return quizName;
    }

    public void setQuizName(String quizName) {
        this.quizName = quizName;
    }

    public double getPassRate() {
        return passRate;
    }

    public void setPassRate(double passRate) {
        this.passRate = passRate;
    }

    public String getQuizType() {
        return quizType;
    }

    public void setQuizType(String quizType) {
        this.quizType = quizType;
    }

    public int getQuizDuration() {
        return quizDuration;
    }

    public void setQuizDuration(int quizDuration) {
        this.quizDuration = quizDuration;
    }

    public String getQuizLevel() {
        return quizLevel;
    }

    public void setQuizLevel(String quizLevel) {
        this.quizLevel = quizLevel;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
    
    
}