<%@page import="kr.co.yomozomo.vo.QajoinVO"%>
<%@page import="kr.co.yomozomo.dao.QaboardDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device=widht, initial-scale=1">
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../lang/summernote-ko-KR.js"></script>
<script type="text/javascript"> 
	
</script>
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");		
		
		String no = request.getParameter("qab_num");
		
		if(no != null){
			
			int qab_num = Integer.parseInt(no);
			
			QaboardDAO dao = new QaboardDAO();
			
			QajoinVO vo = dao.joinOne(qab_num);
			
			
	%>
	<form action="qa_modifyOk.jsp" method="post" enctype="multipart/form-data">
		<div class="container">
			<table class="table table-bordered table-striped">
				<tr>
					<th>작성자</th>
					<td>
					<input type="text" name="writer" id="" disabled="disabled" value="<%= vo.getNICKNAME() %>"/>
					<input type="hidden" name="writer" id="" value="<%= vo.getM_NUM()  %>"/>
					<input type="hidden" name="qab_num" value="<%=vo.getQAB_NUM() %>"/>
					</td>
					
				</tr>
				<tr>
	
					<th>제목</th>
					<td><input type="text" name="title" id="" value="<%= vo.getQAB_TITLE() %>" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="contents" rows="20" cols="80" name="contents"><%=vo.getQAB_CONTENTS() %></textarea>
					</td>
				</tr>
				<tr>
				<th>첨부파일</th>
				<td><input type="file" name="filename" id="" /></td>
			   </tr>
				<tr>
				<td colspan="6">
					<input type="submit" value="수정완료" class="btn btn-primary" />
					<a href="pic_detail.jsp?qab_num=<%=vo.getQAB_NUM()%>"><input type="button" value="취소" class="btn btn-danger"/></a>
				</td>
				</tr>
			</table>
		</div>	
	</form>
	<%
		}	
	%>
	

</body>
</html>