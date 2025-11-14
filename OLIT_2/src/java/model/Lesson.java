/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Lesson {
    private int lessonID;
    private int moduleID;
    private String lessonTitle;
    private String lessonDetail;
    private boolean status;
    private String URLLesson;
    private int order;

    public Lesson() {
    }

    public Lesson(int lessonID, int moduleID, String lessonTitle, String lessonDetail, boolean status, String URLLesson, int order) {
        this.lessonID = lessonID;
    
        this.moduleID = moduleID;
        this.lessonTitle = lessonTitle;
        this.lessonDetail = lessonDetail;
        this.status = status;
        this.URLLesson = URLLesson;
        this.order = order;
    }


    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    public int getModuleID() {
        return moduleID;
    }

    public void setModuleID(int moduleID) {
        this.moduleID = moduleID;
    }

    public String getLessonTitle() {
        return lessonTitle;
    }

    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }

    public String getLessonDetail() {
        return lessonDetail;
    }

    public void setLessonDetail(String lessonDetail) {
        this.lessonDetail = lessonDetail;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getURLLesson() {
        return URLLesson;
    }

    public void setURLLesson(String URLLesson) {
        this.URLLesson = URLLesson;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }
    
    
}
