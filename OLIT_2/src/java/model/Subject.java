/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Subject {
    private int subjectID;
    private String subjectName;
    private String category;
    private int ownerId;
    private String ownerName; // getter/setter
    private int numOfLessons;
    private boolean status;

    public Subject() {
    }

    public Subject(int subjectID, String subjectName, String category, int ownerId, int numOfLessons, String ownerName, boolean status) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
        this.category = category;
        this.ownerId = ownerId;
        this.numOfLessons = numOfLessons;
        this.status = status;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getNumOfLessons() {
        return numOfLessons;
    }

    public void setNumOfLessons(int numOfLessons) {
        this.numOfLessons = numOfLessons;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }
    
    
}
