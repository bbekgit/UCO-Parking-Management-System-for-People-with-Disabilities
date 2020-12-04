package com.ucoParking.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.opencsv.CSVReader;
import com.opencsv.bean.ColumnPositionMappingStrategy;
import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.StatefulBeanToCsv;
import com.opencsv.bean.StatefulBeanToCsvBuilder;
import com.ucoParking.beans.AdminUser;
import com.ucoParking.beans.Location;
import com.ucoParking.beans.UserLogin;

public class LocationService {

	public final static String USER_PATH = "D:\\";
	public final static String LOCATIONS_FILE = USER_PATH+"location.csv";
	public final static String ADMIN_FILE = USER_PATH+"adminUser.csv";
	public final static String USER_FILE = USER_PATH+"appUser.csv";
	
	public static List<Location> readCsvFile(){
		try {
				List<Location> locations = new ArrayList<Location>();
				File locationFile = new File(LOCATIONS_FILE);
				
				locationFile.createNewFile();
				
				CsvToBean csv = new CsvToBean();
		        ColumnPositionMappingStrategy strategy = new ColumnPositionMappingStrategy();
		        
		        try {
		        	CSVReader csvReader = new CSVReader(new FileReader(LOCATIONS_FILE));
			        strategy.setType(Location.class);
			        
			        String[] columns = new String[] {"lat","lng","latLng","name","createdDate","modifiedDate","status","assignedToName","assignedToDetails","locationId"};
			        strategy.setColumnMapping(columns);
			        List list = csv.parse(strategy, csvReader);
			        for (Object object : list) {
			        	Location location = (Location) object;
			        	if(location.getLocationId() != 0 
			        			&& !location.getName().equals(""))
			        		locations.add(location);
			        }
		        }
		        catch(Exception ex) {
		        	System.out.println("Exception Occuerd"+ ex.toString());
		        }

	            return locations;
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	public static List<AdminUser> readAdminLoginCsvFile(){
		try {
				List<AdminUser> adminUsers = new ArrayList<AdminUser>();
				File adminUserFile = new File(ADMIN_FILE);
				
				adminUserFile.createNewFile();
				
				CsvToBean csv = new CsvToBean();
		        ColumnPositionMappingStrategy strategy = new ColumnPositionMappingStrategy();
		        
		        try {
		        	CSVReader csvReader = new CSVReader(new FileReader(ADMIN_FILE));
			        strategy.setType(AdminUser.class);
			        
			        String[] columns = new String[] {"userName","password"};
			        strategy.setColumnMapping(columns);
			        List list = csv.parse(strategy, csvReader);
			        for (Object object : list) {
			        	AdminUser adminUser = (AdminUser) object;
			        		adminUsers.add(adminUser);
			        }
		        }
		        catch(Exception ex) {
		        	System.out.println("Exception Occuerd"+ ex.toString());
		        }

	            return adminUsers;
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	
	public static List<Location> filterAvailable(List<Location> locations){
		try {
			List<Location> locationsNew = new ArrayList<Location>();
			for(Location location : locations) {
				if(location.getStatus() == 2) {
					locationsNew.add(location);
				}
			}
			return locationsNew;
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
	
	public static Boolean writeCsvFile(List<Location> objects, Class clss) {
		try {
				File customerFile = new File(LOCATIONS_FILE);
				// Creates files if not exists
				customerFile.delete();
				customerFile.createNewFile();
			
				BufferedReader br = null;
		        String line = "";

		        FileWriter writer = new 
	                       FileWriter(customerFile); 	
		        ColumnPositionMappingStrategy mappingStrategy= 
                        new ColumnPositionMappingStrategy(); 
		        mappingStrategy.setType(clss); 
	            
		        List<String> columns = new ArrayList<String>();
		        if(clss == Location.class)
		        	columns.addAll(Arrays.asList("lat","lng","latLng","name","createdDate","modifiedDate","status","assignedToName","assignedToDetails","locationId"));
		        
	            mappingStrategy.setColumnMapping(columns.toArray(new String[columns.size()])); 
	            	
	            StatefulBeanToCsvBuilder builder= 
                        new StatefulBeanToCsvBuilder(writer); 
	            StatefulBeanToCsv beanWriter =  
	            builder.withMappingStrategy(mappingStrategy).build(); 
	  
	            // Write list to StatefulBeanToCsv object 
	            beanWriter.write(objects); 
	  
	            // closing the writer object 
	            writer.close(); 
	            return true;
		}
		catch(Exception ex) {
			ex.printStackTrace();
			return false;
		}
	}
	
	public static Location getLocationByLocationId(long locationId, List<Location> locations) {
		try {
			Location location = locations.stream()
                    .filter(x -> locationId == x.getLocationId())
                    .findAny()                                   
                    .orElse(null);
			return location;
		}
		catch(Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}
	public static String getCurrentDateAndTime() {
		   DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");  
		   LocalDateTime now = LocalDateTime.now();  
		   return dtf.format(now);
	}

	public static List<UserLogin> readUserLoginCsvFile() {

		try {
				List<UserLogin> userLogins = new ArrayList<UserLogin>();
				File adminUserFile = new File(USER_FILE);
				
				adminUserFile.createNewFile();
				
				CsvToBean csv = new CsvToBean();
		        ColumnPositionMappingStrategy strategy = new ColumnPositionMappingStrategy();
		        
		        try {
		        	CSVReader csvReader = new CSVReader(new FileReader(USER_FILE));
			        strategy.setType(UserLogin.class);
			        
			        String[] columns = new String[] {"userId","userName"};
			        strategy.setColumnMapping(columns);
			        List list = csv.parse(strategy, csvReader);
			        for (Object object : list) {
			        	UserLogin userLogin = (UserLogin) object;
			        	userLogins.add(userLogin);
			        }
		        }
		        catch(Exception ex) {
		        	System.out.println("Exception Occuerd"+ ex.toString());
		        }

	            return userLogins;
		}	
		catch(Exception ex) {
			ex.printStackTrace();
		}
		return null;
	
	}
	  
	public static List<Location> getAssignedLocations(List<Location> locations, String userName){
		List<Location> locationsNew = new ArrayList<Location>();
		for(Location location : locations) {
			if(location.getAssignedToName().equals(userName)) {
				locationsNew.add(location); 
			}
		}
		return locationsNew;
	}
	
	public static AdminUser getAdminUser(String name, String pwd, List<AdminUser> adminUsers) {
		AdminUser adminUser = adminUsers.stream()
                .filter(x -> name.equalsIgnoreCase(x.getUserName()) && pwd.equals(x.getPassword()) )
                .findAny()                                   
                .orElse(null);
		return adminUser;
	}
	
	public static UserLogin getUserLogin(String userId, String userName, List<UserLogin> adminUsers) {
		UserLogin userLogin = adminUsers.stream()
                .filter(x -> userId.equals(x.getUserId()) && userName.equals(x.getUserName()))
                .findAny()                                   
                .orElse(null);
		return userLogin;
	}
}
