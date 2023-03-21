package Inventory;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class DeleteInventoryController
 */
@WebServlet("/DeleteInventoryController")
public class DeleteInventoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InventoryDAO dao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteInventoryController() {
        super();
        dao = new InventoryDAO();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int invId = Integer.parseInt(request.getParameter("invId"));
		dao.deleteInventory(invId);	
		request.setAttribute("inventories",InventoryDAO.getAllInventories());
		RequestDispatcher view = request.getRequestDispatcher("inventory/inventory_list.jsp");
		view.forward(request,response);

	}
}
