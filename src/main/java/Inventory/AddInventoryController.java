package Inventory;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class AddInventoryController
 */
@WebServlet("/AddInventoryController")
public class AddInventoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InventoryDAO dao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddInventoryController() {
        super();
        dao = new InventoryDAO();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		inventoryModel i = new inventoryModel();
		
		i.setInvName(request.getParameter("invName"));
		i.setInvBrand(request.getParameter("invBrand"));
		i.setInvType(request.getParameter("invType"));
		i.setPurchasePrice(Double.parseDouble(request.getParameter("purchasePrice")));
		i.setSellingPrice(Double.parseDouble(request.getParameter("sellingPrice")));
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date expDate = dateFormat.parse(request.getParameter("expDate"));
			i.setExpDate(expDate);
		} catch (ParseException e) {
			// handle parse exception
			e.printStackTrace();
		}		
		
		i.setInvQty(Integer.parseInt(request.getParameter("invQty")));
		i.setTotalSoldQty(Integer.parseInt(request.getParameter("totalSoldQty")));
		i.setMinInvLevel(Integer.parseInt(request.getParameter("invMinLevel")));		

		dao.addInventory(i); //invoke method addInventory() in InventoryDAO
		
		request.setAttribute("inventories",InventoryDAO.getAllInventories());
		RequestDispatcher view = request.getRequestDispatcher("inventory/inventory_list.jsp");
		view.forward(request,response);

	}
	
	
}
