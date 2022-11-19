package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@MultipartConfig(
		fileSizeThreshold = 1024*1024,
		maxFileSize = 1024*1024*50,
		maxRequestSize = 1024*1024*50*2
		
		)
@WebServlet("/product/review/rr")
public class ReviewWriteController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		request.setCharacterEncoding("utf-8");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String secret = request.getParameter("secret");
		int pnum = Integer.parseInt(request.getParameter("id"));
		if (secret == null || secret.equals(""))
			secret = "N";
		
		
		Collection<Part> parts = request.getParts();
		StringBuilder builder = new StringBuilder();

		for (Part p : parts) {
			if(!p.getName().equals("file")) continue;
			if(p.getSize() ==0) continue;
			
			Part filePart = p;
			String fileName = filePart.getSubmittedFileName();
			builder.append(fileName);
			builder.append(",");
			
			InputStream fis = filePart.getInputStream();
			String realPath = request.getServletContext().getRealPath("/uploadReview");
//			System.out.println(realPath); // 실제 파일이 저장되는 경로임 eclipse상 upload 경로가아니라
			String filePath = realPath + File.separator + fileName;
//			System.out.println(filePath);
			FileOutputStream fos = new FileOutputStream(filePath);

			byte[] buf = new byte[1024];
			int size = 0;
			while ((size = fis.read(buf)) != -1) 
				fos.write(buf, 0, size);
			
			fos.close();
			fis.close();
		}
		builder.delete(builder.length()-1, builder.length());
//		System.out.println(builder.toString());
		
		
		
		response.sendRedirect("/yomozomo/product/review?id="+pnum);
	}
}