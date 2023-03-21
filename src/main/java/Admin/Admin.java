package Admin;

public class Admin {
	private int adminId;
	private String adminName;
	private String adminPhoneNo;
	private String adminEmail;
	private String adminPassword;
	private String userType;

	private boolean valid;

	

	public Admin() {
		
	}



	public int getAdminId() {
		return adminId;
	}



	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}



	public String getAdminName() {
		return adminName;
	}



	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}



	public String getAdminPhoneNo() {
		return adminPhoneNo;
	}



	public void setAdminPhoneNo(String adminPhoneNo) {
		this.adminPhoneNo = adminPhoneNo;
	}



	public String getAdminEmail() {
		return adminEmail;
	}



	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}



	public String getAdminPassword() {
		return adminPassword;
	}



	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}



	public String getUserType() {
		return userType;
	}



	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public boolean isValid() {
		return valid;
	}
	public void setValid(boolean valid) {
		this.valid = valid;
	}		
	
	
}
