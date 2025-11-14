/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long0
 */
public class Course {

    private int courseID;
    private int subjectID;
    private String courseTitle;
    private String courseTag;
    private String urlCourse;
    private String courseDetail;
    private String courseLevel;
    private String featureFlag;
    private int status;
    private int courseraDuration;

    public Course() {
    }

    public Course(int courseID, int subjectID, String courseTitle, String courseTag, String urlCourse, String courseDetail, String courseLevel, String featureFlag, int status, int courseraDuration) {
        this.courseID = courseID;
        this.subjectID = subjectID;
        this.courseTitle = courseTitle;
        this.courseTag = courseTag;
        this.urlCourse = urlCourse;
        this.courseDetail = courseDetail;
        this.courseLevel = courseLevel;
        this.featureFlag = featureFlag;
        this.status = status;
        this.courseraDuration = courseraDuration;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }
    
    

    public String getCourseTag() {
        return courseTag;
    }

    public void setCourseTag(String courseTag) {
        this.courseTag = courseTag;
    }

    public String getUrlCourse() {
        return urlCourse;
    }

    public void setUrlCourse(String urlCourse) {
        this.urlCourse = urlCourse;
    }

    public String getCourseDetail() {
        return courseDetail;
    }

    public void setCourseDetail(String courseDetail) {
        this.courseDetail = courseDetail;
    }

    public String getCourseLevel() {
        return courseLevel;
    }

    public void setCourseLevel(String courseLevel) {
        this.courseLevel = courseLevel;
    }

    public String getFeatureFlag() {
        return featureFlag;
    }

    public void setFeatureFlag(String featureFlag) {
        this.featureFlag = featureFlag;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCourseraDuration() {
        return courseraDuration;
    }

    public void setCourseraDuration(int courseraDuration) {
        this.courseraDuration = courseraDuration;
    }

}
