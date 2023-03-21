package Inventory;

import java.sql.*;
import java.util.*;
import db.connection.ConnectionManager;

public class InventoryDAO {
	static Connection con = null;
	static PreparedStatement ps = null;
	static Statement stmt = null;
	static ResultSet rs = null;
		
	
	private int invId, invQty;
	public int totalSoldQty,minInvLevel;
	private String invName, invType, invBrand;
	private double purchasePrice, sellingPrice;
	private java.util.Date expDate;

	
	//add inventory
	public void addInventory(inventoryModel bean)
	{
	    invName = bean.getInvName();
	    invBrand = bean.getInvBrand();
	    invType = bean.getInvType();
	    purchasePrice = bean.getPurchasePrice();
	    sellingPrice = bean.getSellingPrice();
	    expDate = bean.getExpDate(); // get the java.util.Date object
	    invQty = bean.getInvQty();
	    totalSoldQty = bean.getTotalSoldQty();
	    minInvLevel = bean.getMinInvLevel();
	    
	    try {
	        //call getConnection() method
	        con = ConnectionManager.getConnection();
	                    
	        //3. create statement
	        ps = con.prepareStatement("INSERT INTO inventory(invName, invBrand, invType, purchasePrice, sellingPrice, expDate, invQty, totalSoldQty, minInvLevel)VALUES(?, ?,?,?,?,?,?,?,?)");
	        ps.setString(1, invName);
	        ps.setString(2, invBrand);
	        ps.setString(3, invType);
	        ps.setDouble(4, purchasePrice);
	        ps.setDouble(5, sellingPrice);
	        
	        
	        // create a java.sql.Date object from the java.util.Date object
	        java.sql.Date sqlExpDate = new java.sql.Date(expDate.getTime());
	        // set the expDate parameter in the prepared statement
	        ps.setDate(6, sqlExpDate);
	        
	        ps.setInt(7, invQty);
	        ps.setInt(8, totalSoldQty);
	        ps.setInt(9, minInvLevel);



	        //4. execute query
	        ps.executeUpdate();
	        System.out.println("Successfully inserted");
	        
	        //5. close connection
	        con.close();

	    } catch(Exception e) {
	        e.printStackTrace();
	        System.out.println(e);
	    }
	}

	//get all inventories
	public static List<inventoryModel> getAllInventories()
	{
		List<inventoryModel> inventories = new ArrayList<inventoryModel>();
		
		
		
		
		try {
			//callC getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			stmt = con.createStatement();
			String sql = "SELECT * FROM inventory ORDER BY invId";
			//String sql2 = "select * CONVERT (varchar(10), expDate, 103) AS [DD/MM/YYYY] ";
			
			//4. execute query
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				//process result
				inventoryModel i = new inventoryModel();
				i.setInvId(rs.getInt("invId"));
				i.setInvName(rs.getString("invName"));
				i.setInvBrand(rs.getString("invBrand"));
				i.setInvType(rs.getString("invType"));
				i.setPurchasePrice(rs.getDouble("purchasePrice"));
				i.setSellingPrice(rs.getDouble("sellingPrice"));    
				i.setExpDate(rs.getDate("expDate"));
				i.setInvQty(rs.getInt("invQty"));
				i.setTotalSoldQty(rs.getInt("totalSoldQty"));
				i.setMinInvLevel(rs.getInt("minInvLevel"));

				
				inventories.add(i);
			}
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		
		return inventories;
		
	}
	
	//get inventory id
	
	public static inventoryModel getInventoryById(int invId)
	{
		inventoryModel i = new inventoryModel();
		
		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM inventory where invId=?");
			ps.setInt(1,invId);
						
			//4. execute query
			rs = ps.executeQuery();
			if(rs.next())
			{
				
				i.setInvId(rs.getInt("invId"));
				i.setInvName(rs.getString("invName"));
				i.setInvBrand(rs.getString("invBrand"));
				i.setInvType(rs.getString("invType"));
				i.setPurchasePrice(rs.getDouble("purchasePrice"));
				i.setSellingPrice(rs.getDouble("sellingPrice"));
				i.setExpDate(rs.getDate("expDate"));
				i.setInvQty(rs.getInt("invQty"));
				i.setMinInvLevel(rs.getInt("minInvLevel"));

			}
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return i;
		
	}
	
	//delete inventory
	public void deleteInventory(int invId)
	{
		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("DELETE FROM inventory WHERE invId=?");
			ps.setInt(1, invId);
			
			//4. execute query
			ps.executeUpdate();
			
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	
	//update inventory
	
	public void updateInventory(inventoryModel bean)
	{
		invId = bean.getInvId();
		invName = bean.getInvName();
		invBrand = bean.getInvBrand();
		invType = bean.getInvType();
		purchasePrice = bean.getPurchasePrice();
		sellingPrice = bean.getSellingPrice();
	    expDate = bean.getExpDate(); // get the java.util.Date object
		invQty = bean.getInvQty();

		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("UPDATE inventory SET invName=?, invBrand=?, invType=?, purchasePrice=?, sellingPrice=?, expDate=?, invQty=?, minInvLevel=? WHERE invId=?");
			ps.setString(1, invName);
			ps.setString(2, invBrand);
			ps.setString(3, invType);
			ps.setDouble(4, purchasePrice);
			ps.setDouble(5, sellingPrice);
			
			
			// set the expDate parameter in the prepared statement
	        ps.setDate(6, new java.sql.Date(expDate.getTime()));
			
			ps.setInt(7, invQty);
			ps.setInt(8, minInvLevel);

			ps.setInt(9, invId);
			
			//4. execute query
			ps.executeUpdate();
			
			System.out.println("Succesfully updated");
			
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
}
