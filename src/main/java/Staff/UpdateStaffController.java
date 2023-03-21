package Staff;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdatePrescriptionController
 */

@WebServlet("/UpdateStaffController")
public class UpdateStaffController extends HttpServlet
{
	private static final long serialVersionUID = 1L;	
	private StaffDAO dao;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateStaffController()
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
		RequestDispatcher view = request.getRequestDispatcher("staff/staff_update.jsp");
		view.forward(request,response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//TODO Auto-generated method stub
		Staff s = new Staff();
		
		s.setStaffName(request.getParameter("staffName"));
		s.setStaffPhoneNo(request.getParameter("staffPhoneNo"));
		s.setStaffEmail(request.getParameter("staffEmail"));
		s.setStaffPassword(request.getParameter("staffPassword"));
		s.setUserType(request.getParameter("userType"));
		s.setStaffId(Integer.parseInt(request.getParameter("staffId")));

		
		dao.updateStaff(s); //invoke method updateStaff() in StaffDAO
		
		request.setAttribute("staffs",StaffDAO.getAllStaff());
		RequestDispatcher view = request.getRequestDispatcher("staff/staff_list.jsp");
		view.forward(request,response);
	}
}
