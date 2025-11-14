/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author macbook
 */
public class PricePackage {
    private int PackageID;
    private int CourseID;
    private String Name;
    private int AccessDuration;
    private int ListPrice;
    private int SalePrice;
    private int Status;
    private String Description;

    public PricePackage() {
    }

    public PricePackage(int PackageID, int CourseID, String Name, int AccessDuration, int ListPrice, int SalePrice, int Status, String Description) {
        this.PackageID = PackageID;
        this.CourseID = CourseID;
        this.Name = Name;
        this.AccessDuration = AccessDuration;
        this.ListPrice = ListPrice;
        this.SalePrice = SalePrice;
        this.Status = Status;
        this.Description = Description;
    }

    public int getPackageID() {
        return PackageID;
    }

    public void setPackageID(int PackageID) {
        this.PackageID = PackageID;
    }

    public int getCourseID() {
        return CourseID;
    }

    public void setCourseID(int CourseID) {
        this.CourseID = CourseID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public int getAccessDuration() {
        return AccessDuration;
    }

    public void setAccessDuration(int AccessDuration) {
        this.AccessDuration = AccessDuration;
    }

    public int getListPrice() {
        return ListPrice;
    }

    public void setListPrice(int ListPrice) {
        this.ListPrice = ListPrice;
    }

    public int getSalePrice() {
        return SalePrice;
    }

    public void setSalePrice(int SalePrice) {
        this.SalePrice = SalePrice;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }
    
    
}
