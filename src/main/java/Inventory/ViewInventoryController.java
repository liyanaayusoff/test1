package Inventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class ViewInventoryController
 */

@WebServlet("/ViewInventoryController")
public class ViewInventoryController extends HttpServlet
{
	private static final long serialVersionUID = 1L;	
	private InventoryDAO dao;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewInventoryController()
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
		RequestDispatcher view = request.getRequestDispatcher("inventory/inventory_view.jsp");
		view.forward(request,response);
	}

	public InventoryDAO getDao() {
		return dao;
	}

	public void setDao(InventoryDAO dao) {
		this.dao = dao;
	}
}

