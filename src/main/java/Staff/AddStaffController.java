package Staff;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class AddOwnerController
 */
@WebServlet("/AddStaffController")
public class AddStaffController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StaffDAO dao;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStaffController() {
        super();
        dao = new StaffDAO();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Staff o = new Staff();
		
		o.setStaffName(request.getParameter("staffName"));
		o.setStaffPhoneNo(request.getParameter("staffPhoneNo"));
		o.setStaffEmail(request.getParameter("staffEmail"));
		o.setStaffPassword(request.getParameter("staffPassword"));
		o.setUserType(request.getParameter("userType"));
		
		
		dao.addStaff(o); //invoke method addOwner() in OwnerDAO
		
		request.setAttribute("staffs",StaffDAO.getAllStaff());
		RequestDispatcher view = request.getRequestDispatcher("staff/staff_list.jsp");
		view.forward(request,response);

	}
	
	
}
