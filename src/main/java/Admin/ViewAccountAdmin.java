package Admin;

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

@WebServlet("/ViewAccountAdmin")
public class ViewAccountAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;	
	private AdminDAO dao;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewAccountAdmin()
	{
		super();
		dao = new AdminDAO();
		
		//TODO Auto-generated constructor stub
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//TODO Auto-generated method stub
		int adminId = Integer.parseInt(request.getParameter("adminId"));
		request.setAttribute("us",AdminDAO.getAdminById(adminId));
		RequestDispatcher view = request.getRequestDispatcher("system/admin_account.jsp");
		view.forward(request,response);
	}

	public AdminDAO getDao() {
		return dao;
	}

	public void setDao(AdminDAO dao) {
		this.dao = dao;
	}
}

