/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

public class CourseSection {
    private int sectionID;
    private int courseID;
    private String sectionTitle;
    private Quiz quiz;
    
    public Quiz getQuiz() { return quiz; }
    
    public void setQuiz(Quiz quiz) { this.quiz = quiz; }
    
    private List<SectionModule> modules;

    public List<SectionModule> getModules() {
        return modules;
    }
    public void setModules(List<SectionModule> modules) {
        this.modules = modules;
    }

    public CourseSection() {
    }

    public CourseSection(int sectionID, int courseID, String sectionTitle) {
        this.sectionID = sectionID;
        this.courseID = courseID;
        this.sectionTitle = sectionTitle;
    }

    public int getSectionID() {
        return sectionID;
    }

    public void setSectionID(int sectionID) {
        this.sectionID = sectionID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getSectionTitle() {
        return sectionTitle;
    }

    public void setSectionTitle(String sectionTitle) {
        this.sectionTitle = sectionTitle;
    }
    
    
}
