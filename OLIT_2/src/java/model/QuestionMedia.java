/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long0
 */
public class QuestionMedia {

    private int mediaId;
    private String mediaURL;
    private int mediaType;
    private String mediaDescription;
    private int questionId;

    public QuestionMedia() {
    }

    public QuestionMedia(int mediaId, String mediaURL, int mediaType, String mediaDescription, int questionId) {
        this.mediaId = mediaId;
        this.mediaURL = mediaURL;
        this.mediaType = mediaType;
        this.mediaDescription = mediaDescription;
        this.questionId = questionId;
    }

    public int getMediaId() {
        return mediaId;
    }

    public void setMediaId(int mediaId) {
        this.mediaId = mediaId;
    }

    public String getMediaURL() {
        return mediaURL;
    }

    public void setMediaURL(String mediaURL) {
        this.mediaURL = mediaURL;
    }

    public int getMediaType() {
        return mediaType;
    }

    public void setMediaType(int mediaType) {
        this.mediaType = mediaType;
    }

    public String getMediaDescription() {
        return mediaDescription;
    }

    public void setMediaDescription(String mediaDescription) {
        this.mediaDescription = mediaDescription;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

}
