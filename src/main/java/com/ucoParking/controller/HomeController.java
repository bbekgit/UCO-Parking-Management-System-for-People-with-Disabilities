package com.ucoParking.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.ucoParking.beans.AdminUser;
import com.ucoParking.beans.Location;
import com.ucoParking.beans.UserLogin;
import com.ucoParking.service.LocationService;

/**
 * Handles requests for the application home page.
 */
	@Controller
	public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "LoginAs";
	}
	
	@RequestMapping(value = "/login/admin", method = RequestMethod.GET)
	public String adminLogin(Model model) {
		return "AdminLogin";
	}
	
	@RequestMapping(value = "/login/admin/submit", method = RequestMethod.GET)
	public String adminLoginSubmit(Model model,
			@RequestParam(value="name", required=true, defaultValue="")String name,
			@RequestParam(value="pwd", required=true, defaultValue="")String pwd) {
		List<AdminUser> adminUsers = LocationService.readAdminLoginCsvFile();
		AdminUser adminUser = LocationService.getAdminUser(name, pwd, adminUsers);
		
		if(adminUser == null) {
			model.addAttribute("msg", "Login Failed.");
			return "AdminLogin";
		}
		List<Location> locations = LocationService.readCsvFile();
		model.addAttribute("locations", locations);
		Gson gson = new Gson();
		try {
			model.addAttribute("locationsJson", gson.toJson(locations));
		}
		catch(Exception ex) {
		}
		return "homeScreen";
	}

	@RequestMapping(value = "/login/user", method = RequestMethod.GET)
	public String userLogin(Model model) {
		return "UserLogin";
	}
	
	@RequestMapping(value = "/login/user/submit", method = RequestMethod.GET)
	public String userLoginSubmit(Model model,
			@RequestParam(value = "userId", required = false,defaultValue = "-1") String userId,
			@RequestParam(value = "userName", required = false,defaultValue = "-1") String userName) 
	{

		List<UserLogin> adminUsers = LocationService.readUserLoginCsvFile();
		UserLogin userLogin = LocationService.getUserLogin(userId, userName, adminUsers);
		
		if(userLogin == null) {
			model.addAttribute("msg", "Login Failed.");
			return "UserLogin";
		}
		List<Location> locations = LocationService.readCsvFile();
		List<Location> locationsAssigned =LocationService.getAssignedLocations(locations, userName);
		
		model.addAttribute("locations", locationsAssigned);
		model.addAttribute("name", userName);
		Gson gson = new Gson();
		try {
			model.addAttribute("locationsJson", gson.toJson(locationsAssigned));
		}
		catch(Exception ex) {
		}
		return "UsersHomeScreen";
	}

	@RequestMapping(value = "/change/status", method = RequestMethod.GET)
	public String changeStatus(@RequestParam(value = "locationId", required = false,defaultValue = "-1") long locationId,
			Model model) {
		List<Location> locations = LocationService.readCsvFile();
		Location location = LocationService.getLocationByLocationId(locationId, locations);
		model.addAttribute("location", location);
		
		return "changeLocStatus";
	}
	
	@RequestMapping(value = "/change/status/submit", method = RequestMethod.GET)
	public String changeStatusSubmit(
			@RequestParam(value = "locationId", required = false,defaultValue = "-1") long locationId,
			@RequestParam(value = "status", required = false,defaultValue = "-1") int status,
			@RequestParam(value = "assignedToName", required = false,defaultValue = "-1") String assignedToName,
			Model model) 
	{
		List<Location> locations = LocationService.readCsvFile();
		Location location = LocationService.getLocationByLocationId(locationId, locations);
		location.setStatus(status);
		location.setAssignedToName(assignedToName);
		location.setModifiedDate(LocationService.getCurrentDateAndTime());
		
		LocationService.writeCsvFile(locations, Location.class);
		model.addAttribute("locations", locations);
		Gson gson = new Gson();
		try {
			model.addAttribute("locationsJson", gson.toJson(locations));
		}
		catch(Exception ex) {
		}
		model.addAttribute("msg", location.getName()+" updated Successfully.");
		return "homeScreen";
	}
	
	@RequestMapping(value = "/search/location", method = RequestMethod.GET)
	public String viewLocation(Model model) {
		List<Location> locations = LocationService.readCsvFile();
		List<Location> locationsNew = LocationService.filterAvailable(locations);
		Gson gson = new Gson();
		try {
			model.addAttribute("locationsJson", gson.toJson(locationsNew));
		}
		catch(Exception ex) {
		}
		model.addAttribute("locations", locations);
		return "viewLocation";
	}
	
	@RequestMapping(value = "/add/location", method = RequestMethod.GET)
	public String addLocation(Model model) {
		return "addLocation";
	}
	
	@RequestMapping(value = "/add/location/submit", method = RequestMethod.POST)
	public String saveLocation(@ModelAttribute("location") Location location,
			Locale locale, Model model) {
		List<Location> locations = LocationService.readCsvFile();
		
		String dateTime = LocationService.getCurrentDateAndTime();
		Random rnd = new Random();
		int n = 10000 + rnd.nextInt(90000);
		location.setLocationId(n);
		location.setCreatedDate(dateTime);
		location.setModifiedDate(dateTime);
		
		locations.add(location);
		LocationService.writeCsvFile(locations, Location.class);
		model.addAttribute("success", "Location Added Successfully.");
		locations = new ArrayList<Location>();
		locations = LocationService.readCsvFile();
		model.addAttribute("locations", locations);
		Gson gson = new Gson();
		try {
			model.addAttribute("locationsJson", gson.toJson(locations));
		}
		catch(Exception ex) {
		}
		return "homeScreen";
	}
	
	@RequestMapping(value = "/checkout/location", method = RequestMethod.GET)
	public String checkOutLocation(@ModelAttribute("name") String name,
			Locale locale, Model model) {
		List<Location> locations = LocationService.readCsvFile();
		Iterator<Location> itr = locations.iterator();
		while(itr.hasNext()) {
			Location loc = itr.next();
			if(loc.getAssignedToName().equals(name)) {
				loc.setStatus(2);
				loc.setAssignedToName("");
			}
		}
		LocationService.writeCsvFile(locations, Location.class);
		model.addAttribute("msg", "Location Checked Out Successfully.");
		
		List<Location> locationsAssigned =LocationService.getAssignedLocations(locations, name);
		
		model.addAttribute("locations", locationsAssigned);
		model.addAttribute("name", name);
		Gson gson = new Gson();
		try {
			model.addAttribute("locationsJson", gson.toJson(locationsAssigned));
		}
		catch(Exception ex) {
		}
		return "UsersHomeScreen";
	}
	

	
}
