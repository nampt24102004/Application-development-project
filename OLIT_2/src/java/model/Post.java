/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Post {

    private int postID;
    private int userID;
    private int categoryID;
    private String blogTitle;
    private String postDetails;
    private int status;
    private String updatedDate;
    private String thumbnailURL;
    private Account account;
    private PostCategory postCategory;
    private Boolean isHot;

    public Post() {
    }

    public Post(int postID, int userID, int categoryID, String blogTitle, String postDetails, int status, String updatedDate, String thumbnailURL) {
        this.postID = postID;
        this.userID = userID;
        this.categoryID = categoryID;
        this.blogTitle = blogTitle;
        this.postDetails = postDetails;
        this.status = status;
        this.updatedDate = updatedDate;
        this.thumbnailURL = thumbnailURL;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getBlogTitle() {
        return blogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    public String getPostDetails() {
        return postDetails;
    }

    public void setPostDetails(String postDetails) {
        this.postDetails = postDetails;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getThumbnailURL() {
        return thumbnailURL;
    }

    public void setThumbnailURL(String thumbnailURL) {
        this.thumbnailURL = thumbnailURL;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public PostCategory getPostCategory() {
        return postCategory;
    }

    public void setPostCategory(PostCategory postCategory) {
        this.postCategory = postCategory;
    }

    public Boolean getIsHot() {
        return isHot;
    }

    public void setIsHot(Boolean isHot) {
        this.isHot = isHot;
    }

    
    
    
    

    @Override
    public String toString() {
        return "Post{" + "postID=" + postID + ", userID=" + userID + ", categoryID=" + categoryID + ", blogTitle=" + blogTitle + ", postDetails=" + postDetails + ", status=" + status + ", updatedDate=" + updatedDate + ", thumbnailURL=" + thumbnailURL + '}';
    }

    
    
}
