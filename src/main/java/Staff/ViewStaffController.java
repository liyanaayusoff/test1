package Staff;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class ViewPrescriptionController
 */

@WebServlet("/ViewStaffController")
public class ViewStaffController extends HttpServlet
{
	private static final long serialVersionUID = 1L;	
	private StaffDAO dao;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewStaffController()
	{
		super();
		dao = new StaffDAO();
		
		//TODO Auto-generated constructor stub
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//TODO Auto-generated method stub
		int staffId = Integer.parseInt(request.getParameter("staffId"));
		request.setAttribute("s",StaffDAO.getStaffById(staffId));
		RequestDispatcher view = request.getRequestDispatcher("staff/staff_view.jsp");
		view.forward(request,response);
	}

	public StaffDAO getDao() {
		return dao;
	}

	public void setDao(StaffDAO dao) {
		this.dao = dao;
	}
}
