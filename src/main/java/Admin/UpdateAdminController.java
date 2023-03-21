package Admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateAdminController
 */

@WebServlet("/UpdateAdminController")
public class UpdateAdminController extends HttpServlet
{
	private static final long serialVersionUID = 1L;	
	private AdminDAO dao;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateAdminController()
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
		request.setAttribute("s",AdminDAO.getAdminById(adminId));
		RequestDispatcher view = request.getRequestDispatcher("system/admin_account_edit.jsp");
		view.forward(request,response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//TODO Auto-generated method stub
		Admin s = new Admin();
		
		s.setAdminName(request.getParameter("adminName"));
		s.setAdminPhoneNo(request.getParameter("adminPhoneNo"));
		s.setAdminEmail(request.getParameter("adminEmail"));
		s.setAdminPassword(request.getParameter("adminPassword"));
		s.setUserType(request.getParameter("userType"));
		s.setAdminId(Integer.parseInt(request.getParameter("adminId")));

		
		dao.updateAdmin(s); //invoke method updateStaff() in StaffDAO
		
		request.setAttribute("admins",AdminDAO.getAllAdmin());
		RequestDispatcher view = request.getRequestDispatcher("system/admin_account.jsp");
		view.forward(request,response);
	}
}
