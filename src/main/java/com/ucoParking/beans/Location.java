package com.ucoParking.beans;

import java.io.Serializable;

public class Location implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private double lat;
	private double lng;
	private String latLng;
	private String name;
	private String createdDate;
	private String modifiedDate;
	private int status=2;// 1) Hold, 2) Available, 3)UnAvailable
	private String assignedToName;
	private String assignedToDetails;
	private long locationId;
	
	public String getAssignedToName() {
		return assignedToName;
	}
	public void setAssignedToName(String assignedToName) {
		this.assignedToName = assignedToName;
	}
	public String getAssignedToDetails() {
		return assignedToDetails;
	}
	public void setAssignedToDetails(String assignedToDetails) {
		this.assignedToDetails = assignedToDetails;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public String getLatLng() {
		return latLng;
	}
	public void setLatLng(String latLng) {
		this.latLng = latLng;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(String modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public long getLocationId() {
		return locationId;
	}
	public void setLocationId(long locationId) {
		this.locationId = locationId;
	}
	
	@Override
	public String toString() {
		return "Location [lat=" + lat + ", lng=" + lng + ", latLng=" + latLng + ", name=" + name + ", createdDate="
				+ createdDate + ", modifiedDate=" + modifiedDate + ", status=" + status + ", assignedToName="
				+ assignedToName + ", assignedToDetails=" + assignedToDetails + ", locationId=" + locationId + "]";
	}
	
}
