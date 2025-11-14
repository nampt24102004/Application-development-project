/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Question {

    private int questionID;
    private String questionContent;
    private int questionType;
    private boolean status;
    private int questionLevel;
    private int createdBy;
    private LocalDateTime createdAt; // Đã thay đổi từ String sang LocalDateTime
    private int subjectID;
    private int lessonID;

    public Question() {
        // Constructor mặc định có thể khởi tạo createdAt bằng thời gian hiện tại
        this.createdAt = LocalDateTime.now();
    }

    // Constructor khi lấy dữ liệu từ Database (hoặc tạo đối tượng đầy đủ)
    public Question(int questionID, String questionContent, int questionType, boolean status, int questionLevel, int createdBy, LocalDateTime createdAt, int subjectID, int lessonID) {
        this.questionID = questionID;
        this.questionContent = questionContent;
        this.questionType = questionType;
        this.status = status;
        this.questionLevel = questionLevel;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.subjectID = subjectID;
        this.lessonID = lessonID;
    }

    // Constructor tiện lợi cho việc tạo mới mà không cần ID
    public Question(String questionContent, int questionType, boolean status, int questionLevel, int createdBy, int subjectID, int lessonID) {
        this.questionContent = questionContent;
        this.questionType = questionType;
        this.status = status;
        this.questionLevel = questionLevel;
        this.createdBy = createdBy;
        this.subjectID = subjectID;
        this.lessonID = lessonID;
        this.createdAt = LocalDateTime.now(); // Tự động thiết lập thời gian tạo khi khởi tạo
    }

    // --- Getters and Setters ---
    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public int getQuestionType() {
        return questionType;
    }

    public String getQuestionTypeStr() {
        return questionType == 1 ? "Type 1" : "Type 2"; // Hoặc có thể dùng Enum cho QuestionType
    }

    public void setQuestionType(int questionType) {
        this.questionType = questionType;
    }

    public boolean isStatus() {
        return status;
    }

    public String isStatusStr() {
        return (status ? "Active" : "Inactive");
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getQuestionLevel() {
        return questionLevel;
    }

    public void setQuestionLevel(int questionLevel) {
        this.questionLevel = questionLevel;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public int getLessonID() {
        return lessonID;
    }

    public void setLessonID(int lessonID) {
        this.lessonID = lessonID;
    }

    // --- Các phương thức hỗ trợ định dạng hiển thị ---
    public String getFormattedDate() {
        if (createdAt == null) {
            return "";
        }
        // Định dạng ngày theo dd/MM/yyyy
        return createdAt.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getFormattedTime() {
        if (createdAt == null) {
            return "";
        }
        // Định dạng giờ theo HH:mm
        return createdAt.format(DateTimeFormatter.ofPattern("HH:mm"));
    }
}
