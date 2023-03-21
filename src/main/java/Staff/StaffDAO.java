
package Staff;

import java.sql.*;

import java.util.*;
import db.connection.ConnectionManager;

public class StaffDAO {
	static Connection con = null;
	static PreparedStatement ps = null;
	static Statement stmt = null;
	static ResultSet rs = null;
	
	private int staffId;
	private String staffName, staffPhoneNo, staffEmail, staffPassword, userType;

	//add staff
	public void addStaff(Staff bean)
	{
		staffName = bean.getStaffName();
		staffPhoneNo = bean.getStaffPhoneNo();
		staffEmail = bean.getStaffEmail();
		staffPassword = bean.getStaffPassword();
		userType = bean.getUserType();
	
		
		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("INSERT INTO staff(staffName, staffPhoneNo, staffEmail, staffPassword, userType)VALUES(?,?,?,?,?)");
			ps.setString(1, staffName);
			ps.setString(2, staffPhoneNo);
			ps.setString(3, staffEmail);
			ps.setString(4, staffPassword);
			ps.setString(5, userType);

			//4. execute query
			ps.executeUpdate();
			System.out.println("Successfully inserted");
			
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
	}
	
	//get all staffs
	public static List<Staff> getAllStaff()
	{
		List<Staff> staffs = new ArrayList<Staff>();
		
		try {
			//callC getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			stmt = con.createStatement();
			String sql = "SELECT * FROM staff ORDER BY staffId";
			
			//4. execute query
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				//process result
				Staff o = new Staff();
				o.setStaffId(rs.getInt("staffId"));
				o.setStaffName(rs.getString("staffName"));
				o.setStaffPhoneNo(rs.getString("staffPhoneNo"));
				o.setStaffEmail(rs.getString("staffEmail"));
				o.setStaffPassword(rs.getString("staffPassword"));
				o.setUserType(rs.getString("userType"));
				
				staffs.add(o);
			}
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e);
		}
		
		return staffs;
		
	}
	
	//get staff id
	
	public static Staff getStaffById(int staffId)
	{
		Staff o = new Staff();
		
		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM staff where staffId=?");
			ps.setInt(1,staffId);
						
			//4. execute query
			rs = ps.executeQuery();
			if(rs.next())
			{
				o.setStaffId(rs.getInt("staffId"));
				o.setStaffName(rs.getString("staffName"));
				o.setStaffPhoneNo(rs.getString("staffPhoneNo"));
				o.setStaffEmail(rs.getString("staffEmail"));
				o.setStaffPassword(rs.getString("staffPassword"));
				o.setUserType(rs.getString("userType"));
					
			}
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return o;
		
	}
	
	//delete staff
	public void deleteStaff(int staffId)
	{
		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("DELETE FROM staff WHERE staffId=?");
			ps.setInt(1, staffId);
			
			//4. execute query
			ps.executeUpdate();
			
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	
	//update staff
	
	public void updateStaff(Staff bean)
	{
		staffId = bean.getStaffId();
		staffName = bean.getStaffName();
		staffPhoneNo = bean.getStaffPhoneNo();
		staffEmail = bean.getStaffEmail();
		staffPassword = bean.getStaffPassword();
		userType = bean.getUserType();
		
		try {
			//call getConnection() method
			con = ConnectionManager.getConnection();
			
			//3. create statement
			ps = con.prepareStatement("UPDATE staff SET staffName=?, staffPhoneNo=?, staffEmail=?, staffPassword=?, userType=? WHERE staffId=?");
			ps.setString(1, staffName);
			ps.setString(2, staffPhoneNo);
			ps.setString(3, staffEmail);
			ps.setString(4, staffPassword);
			ps.setString(5, userType);
			ps.setInt(6, staffId);
			
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
