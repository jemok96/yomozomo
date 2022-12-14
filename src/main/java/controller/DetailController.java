package controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.IntStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QnaService;
import dao.ReviewService;
import dao.StoreService;
import dto.AnsQnaDTO;
import dto.ProductDTO;
import dto.ReviewDTO;

@WebServlet("/detail")
public class DetailController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id")); // 상품 번호 
		
		
		
		StoreService service = new StoreService();
		QnaService ansService = new QnaService();
		ReviewService reService = new ReviewService();
		
		
		List<ReviewDTO> review = reService.getReview(id);
		ProductDTO product = service.getProductDetail(id);
		List<AnsQnaDTO> ans = ansService.getAnswer(id);
		int result = service.updateProductHit(id);
		float star = reService.getRatingAvg(id);
		List<Integer> count = reService.getRatingCount(id);
		
		
		int sum = 0;
		for(int i=0; i<count.size(); i++)
			sum +=count.get(i);
		
		
		
		
		
		request.setAttribute("sum",sum);
		request.setAttribute("count", count);
		request.setAttribute("star", star);
		request.setAttribute("review", review);
		request.setAttribute("ans",ans);
		request.setAttribute("product",product);
		request.getRequestDispatcher("/detail.jsp").forward(request, response);
		
		
		
	}
}
