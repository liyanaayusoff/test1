package Inventory;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateInventoryController
 */

@WebServlet("/UpdateInventoryController")
public class UpdateInventoryController extends HttpServlet
{
	private static final long serialVersionUID = 1L;	
	private InventoryDAO dao;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateInventoryController()
	{
		super();
		dao = new InventoryDAO();
		
		//TODO Auto-generated constructor stub
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//TODO Auto-generated method stub
		int invId = Integer.parseInt(request.getParameter("invId"));
		request.setAttribute("i",InventoryDAO.getInventoryById(invId));
		RequestDispatcher view = request.getRequestDispatcher("inventory/inventory_update.jsp");
		view.forward(request,response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//TODO Auto-generated method stub
		inventoryModel i = new inventoryModel();
		
		i.setInvName(request.getParameter("invName"));
		i.setInvBrand(request.getParameter("invBrand"));
		i.setInvType(request.getParameter("invType"));
		i.setPurchasePrice(Double.parseDouble(request.getParameter("purchasePrice")));
		i.setSellingPrice(Double.parseDouble(request.getParameter("sellingPrice")));
		
		// Convert LocalDate to java.util.Date
		Date expDate = java.sql.Date.valueOf(LocalDate.parse(request.getParameter("expDate")));

		i.setExpDate(expDate);

	
		i.setInvQty(Integer.parseInt(request.getParameter("invQty")));	
		i.setMinInvLevel(Integer.parseInt(request.getParameter("invMinLevel")));		

		i.setInvId(Integer.parseInt(request.getParameter("invId")));

		dao.updateInventory(i); //invoke method updateInventory() in StaffDAO
		
		request.setAttribute("inventories",InventoryDAO.getAllInventories());
		RequestDispatcher view = request.getRequestDispatcher("inventory/inventory_list.jsp");
		view.forward(request,response);
	}
}

