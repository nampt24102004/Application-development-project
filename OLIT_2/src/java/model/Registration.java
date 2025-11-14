/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nam
 */
public class Registration {
    private int RegistrationID;
    private int UserID;
    private int CourseID;
    private int PackageID;
    private int ApprovedBy;
    private String Status;
    private String ValidFrom;
    private String ValidTo;
    private Course Course;
    private PricePackage PricePackage;
    private String userFullName;
    private String userEmail;
    private String userPhone;

    public Registration() {
    }

    public Registration(int RegistrationID, int UserID, int CourseID, int PackageID, String Status) {
        this.RegistrationID = RegistrationID;
        this.UserID = UserID;
        this.CourseID = CourseID;
        this.PackageID = PackageID;
        this.Status = Status;
    }

    public int getRegistrationID() {
        return RegistrationID;
    }

    public void setRegistrationID(int RegistrationID) {
        this.RegistrationID = RegistrationID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public int getCourseID() {
        return CourseID;
    }

    public void setCourseID(int CourseID) {
        this.CourseID = CourseID;
    }

    public int getPackageID() {
        return PackageID;
    }

    public void setPackageID(int PackageID) {
        this.PackageID = PackageID;
    }

    public int getApprovedBy() {
        return ApprovedBy;
    }

    public void setApprovedBy(int ApprovedBy) {
        this.ApprovedBy = ApprovedBy;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getValidFrom() {
        return ValidFrom;
    }

    public void setValidFrom(String ValidFrom) {
        this.ValidFrom = ValidFrom;
    }

    public String getValidTo() {
        return ValidTo;
    }

    public void setValidTo(String ValidTo) {
        this.ValidTo = ValidTo;
    }

    public Course getCourse() {
        return Course;
    }

    public void setCourse(Course Course) {
        this.Course = Course;
    }

    public PricePackage getPricePackage() {
        return PricePackage;
    }

    public void setPricePackage(PricePackage PricePackage) {
        this.PricePackage = PricePackage;
    }

    public String getUserFullName() {
        return userFullName;
    }

    public void setUserFullName(String userFullName) {
        this.userFullName = userFullName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

}
