<%@page import="kr.co.yomozomo.vo.BoardVO"%>
<%@page import="kr.co.yomozomo.dao.BoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

String saveDir = application.getRealPath("/uploadPic");

String realFolder = "C:\\Users\\gkw\\git\\yomozomo\\src\\main\\webapp\\uploadPic";

//첨부파일의 최대 크기
int maxFileSize = 1024*1024*10;

//파라미터값가져오기
MultipartRequest mr = new MultipartRequest(request,realFolder,maxFileSize,"UTF-8",new DefaultFileRenamePolicy());

String writer=mr.getParameter("writer");
String title = mr.getParameter("title");
String contents = mr.getParameter("contents");
String num= mr.getParameter("mnum");
	
//원래 파일의 이름
String f = mr.getOriginalFileName("filename");

String realf = mr.getFilesystemName("filename"); 

int m_num = Integer.parseInt(num);

BoardDAO dao = new BoardDAO();

BoardVO vo = new BoardVO();
	
vo.setB_TITLE(title);
vo.setB_CONTENTS(contents);
vo.setM_NUM(m_num);
vo.setB_IMAGE("/yomozomo/uploadPic/"+f);

dao.insertOne(vo);

response.sendRedirect("b_mngmn1.jsp");
%>