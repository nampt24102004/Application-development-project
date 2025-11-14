/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt để thay đổi giấy phép
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java để chỉnh sửa mẫu này
 */
package model;

import java.sql.Date;

public class Slider {
    private int sliderId;
    private String title;
    private String imageUrl; 
    private int courseID;
    private String backLink;
    private int status;
    private String notes;
    private int displayOrder;
    private Date validFrom;

    public Slider() {
    }

    public Slider(int sliderId, String title, String imageUrl, int courseID, String backLink, int status, String notes, int displayOrder, Date validFrom) {
        this.sliderId = sliderId;
        this.title = title;
        this.imageUrl = imageUrl;
        this.courseID = courseID;
        this.backLink = backLink;
        this.status = status;
        this.notes = notes;
        this.displayOrder = displayOrder;
        this.validFrom = validFrom;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public int getSliderId() {
        return sliderId;
    }

    public void setSliderId(int sliderId) {
        this.sliderId = sliderId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() { // Sửa tên phương thức
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) { // Sửa tên phương thức
        this.imageUrl = imageUrl;
    }

    public String getBackLink() {
        return backLink;
    }

    public void setBackLink(String backLink) {
        this.backLink = backLink;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    @Override
    public String toString() {
        return "Slider{" + "sliderId=" + sliderId + ", title=" + title + ", imageUrl=" + imageUrl + ", backLink=" + backLink 
               + ", status=" + status + ", notes=" + notes + ", displayOrder=" + displayOrder + ", validFrom=" + validFrom + '}';
    }
}