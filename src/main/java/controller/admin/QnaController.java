package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.admin.dao.QnaService;
import controller.admin.dto.AdminQnaDTO;

@WebServlet("/resources/ymzm/q_mngmn")
public class QnaController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page = request.getParameter("cp");
		int page_=1;
		if(page!=null && !page.equals("")) page_ =  Integer.parseInt(request.getParameter("cp")); 
		QnaService qnaService= new QnaService();
		List<AdminQnaDTO> list = qnaService.getAnswer(page_);

		request.setAttribute("list",list);

		request.getRequestDispatcher("/resources/ymzm/q_mngmn.jsp").forward(request, response);
	}
}
