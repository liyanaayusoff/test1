package Admin;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Admin.Admin;
import db.connection.ConnectionManager;

public class AdminDAO {
	
	static Connection con = null;
	static PreparedStatement ps = null;
	static Statement stmt = null;
	static ResultSet rs = null;
		
	
	private int adminId;
	static String adminEmail, adminPassword;
	private String adminName, adminPhoneNo, userType;
	
	
	
	//admin register
		public void registerAdmin (Admin a) throws NoSuchAlgorithmException {

			adminEmail = a.getAdminEmail();
			adminName = a.getAdminName();
			adminPassword = a.getAdminPassword();
			
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(adminPassword.getBytes());

			byte byteData[] = md.digest();

			//convert the byte to hex format
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			String pass = sb.toString();
			
			try {
				con = ConnectionManager.getConnection();			
				ps = con.prepareStatement("insert into admin (adminName, adminPhoneNo, adminEmail,adminPassword,userType) values (?,?,?,?,?)");
				ps.setString(1, adminName);
				ps.setString(2, adminPhoneNo);
				ps.setString(3, adminEmail);
				ps.setString(4, adminPassword);
				ps.setString(5, userType);

				ps.executeUpdate();
			}
			catch (Exception ex) {
				ex.printStackTrace();
				System.out.println(ex);
			}
			
		}
		
			
		//Update reset password
		public void updatePassword(Admin a) {
			
			adminEmail = a.getAdminEmail();
			adminPassword = a.getAdminPassword();

			System.out.println("reset email" + adminEmail);
			System.out.println("reset pass" + adminPassword);

			try {
				con = ConnectionManager.getConnection(); // 2. establish connection
				String query = "update admin set adminPassword='"+adminPassword+"' WHERE adminEmail='"+adminEmail+"'";
				stmt = con.createStatement(); // 3. create statement
				stmt.executeUpdate(query);

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println(e);
			}
		}
		
		//get user by email
		public static Admin getAdminByEmail(String adminEmail) {
			Admin us = new Admin();
			try {
				//call getConnection() method 
				con = ConnectionManager.getConnection();
				//3. create statement  
				ps=con.prepareStatement("select * from admin where adminEmail=?");
				ps.setString(1, adminEmail);
				//4. execute query
				rs = ps.executeQuery();

				if (rs.next()) {	            
					us.setAdminName(rs.getString("setAdminName"));
					us.setAdminPhoneNo(rs.getString("setAdminPhoneNo"));
					us.setAdminEmail(rs.getString("adminEmail"));
					us.setAdminPassword(rs.getString("adminPassword"));
					us.setUserType(rs.getString("userType"));

				}
				//5. close connection
				con.close();
			}catch(Exception e) {
				e.printStackTrace();	
				System.out.println(e);

			}

			return us;
		}

			//method to get admin
	public static Admin getAdmin(Admin bean)  {   
		//get email
		adminEmail = bean.getAdminEmail();
		String searchQuery = "select * from admin where adminEmail='" + adminEmail + "'";
		try {
			//call getConnection() method 
			con = ConnectionManager.getConnection();
			//3. create statement  
			stmt = con.createStatement();
			//execute statement
			rs = stmt.executeQuery(searchQuery);

			boolean more = rs.next();

			// if user exists set the isValid variable to true
			if (more) {
				String adminEmail = rs.getString("adminEmail");
				bean.setAdminEmail(adminEmail);
				bean.setValid(true);
			}
			// if user does not exist set the isValid variable to false
			else if (!more) {
				bean.setValid(false);
			}
			//5. close connection
			con.close();	
		}catch(Exception e) {
			e.printStackTrace();	
			System.out.println(e);

		}
		return bean;
	}
	
	//get user by id
		public static Admin getAdminById(int adminId) {
			Admin ag = new Admin();
			try {
				con = ConnectionManager.getConnection();
				ps=con.prepareStatement("select * from admin where adminId=?");

				ps.setInt(1, adminId);
				ResultSet rs = ps.executeQuery();

				if (rs.next()) {	            
					ag.setAdminId(rs.getInt("adminId"));
					ag.setAdminName(rs.getString("setAdminName"));
					ag.setAdminPhoneNo(rs.getString("setAdminPhoneNo"));
					ag.setAdminEmail(rs.getString("adminEmail"));
					ag.setAdminPassword(rs.getString("adminPassword"));
					ag.setUserType(rs.getString("userType"));

					}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			return ag;
		}

		public int getAdminId() {
			return adminId;
		}

		public void setAdminId(int adminId) {
			this.adminId = adminId;
		}
		
		//get all admins
		public static List<Admin> getAllAdmin()
		{
			List<Admin> admins = new ArrayList<Admin>();
			
			try {
				//callC getConnection() method
				con = ConnectionManager.getConnection();
				
				//3. create statement
				stmt = con.createStatement();
				String sql = "SELECT * FROM admin ORDER BY adminId";
				
				//4. execute query
				rs = stmt.executeQuery(sql);
				
				while(rs.next()) {
					//process result
					Admin o = new Admin();
					o.setAdminId(rs.getInt("adminId"));
					o.setAdminName(rs.getString("adminName"));
					o.setAdminPhoneNo(rs.getString("adminPhoneNo"));
					o.setAdminEmail(rs.getString("adminEmail"));
					o.setAdminPassword(rs.getString("adminPassword"));
					o.setUserType(rs.getString("userType"));
					
					admins.add(o);
				}
				//5. close connection
				con.close();
				
			}catch(Exception e) {
				e.printStackTrace();
				System.out.println(e);
			}
			
			return admins;
			
		}
		
		
		//update admin
		
		public void updateAdmin(Admin bean)
		{
			adminId = bean.getAdminId();
			adminName = bean.getAdminName();
			adminPhoneNo = bean.getAdminPhoneNo();
			adminEmail = bean.getAdminEmail();
			adminPassword = bean.getAdminPassword();
			userType = bean.getUserType();
			
			try {
				//call getConnection() method
				con = ConnectionManager.getConnection();
				
				//3. create statement
				ps = con.prepareStatement("UPDATE admin SET adminName=?, adminPhoneNo=?, adminEmail=?, adminPassword=?, userType=? WHERE staffId=?");
				ps.setString(1, adminName);
				ps.setString(2, adminPhoneNo);
				ps.setString(3, adminEmail);
				ps.setString(4, adminPassword);
				ps.setString(5, userType);
				ps.setInt(6, adminId);
				
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
