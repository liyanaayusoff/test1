package Inventory;


public class inventoryModel {
	private int invId;
	private String invName;
	private String invBrand;
	private String invType;
	private double purchasePrice;
	private double sellingPrice;
	private int invQty;
	private int totalSoldQty;

	
	private java.util.Date expDate;
	
	private int minInvLevel;

	
	public int getInvId() {
		return invId;
	}

	public void setInvId(int invId) {
		this.invId = invId;
	}

	public String getInvName() {
		return invName;
	}

	public void setInvName(String invName) {
		this.invName = invName;
	}

	public String getInvType() {
		return invType;
	}

	public void setInvType(String invType) {
		this.invType = invType;
	}

	public double getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(double purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public double getSellingPrice() {
		return sellingPrice;
	}

	public void setSellingPrice(double sellingPrice) {
		this.sellingPrice = sellingPrice;
	}

	public java.util.Date getExpDate() {
		return expDate;
	}

	public void setExpDate(java.util.Date expDate) {
		this.expDate = expDate;
	}
	
	public int getInvQty() {
		return invQty;
	}

	public void setInvQty(int invQty) {
		this.invQty = invQty;
	}

	public String getInvBrand() {
		return invBrand;
	}

	public void setInvBrand(String invBrand) {
		this.invBrand = invBrand;
	}

	public int getTotalSoldQty() {
		return totalSoldQty;
	}

	public void setTotalSoldQty(int totalSoldQty) {
		this.totalSoldQty = totalSoldQty;
	}

	public int getMinInvLevel() {
		return minInvLevel;
	}

	public void setMinInvLevel(int minInvLevel) {
		this.minInvLevel = minInvLevel;
	}




		
	
}
