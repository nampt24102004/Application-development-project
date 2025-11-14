/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Long0
 */
public class Dimension {

    private int dimensionID;
    private int subjectID;
    private String dimensionName;
    private String description;

    public Dimension() {
    }

    public Dimension(int dimensionID, int subjectID, String dimensionName, String description) {
        this.dimensionID = dimensionID;
        this.subjectID = subjectID;
        this.dimensionName = dimensionName;
        this.description = description;
    }

    public Dimension(int subjectID, String dimensionName, String description) {
        this.subjectID = subjectID;
        this.dimensionName = dimensionName;
        this.description = description;
    }

    public int getDimensionID() {
        return dimensionID;
    }

    public void setDimensionID(int dimensionID) {
        this.dimensionID = dimensionID;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getDimensionName() {
        return dimensionName;
    }

    public void setDimensionName(String dimensionName) {
        this.dimensionName = dimensionName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
