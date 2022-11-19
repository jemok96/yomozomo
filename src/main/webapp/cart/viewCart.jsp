<%@page import="vo.ProductVO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="dao.ProductDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		console.log("이미지 출처: 고양이, 고양이, 동물 https://.pngtree.com/freepng/고양이--고양이--동물_6736820.html?share=1");
		
		var cntnum=parseInt($("#cnt_num").val());
		var stock=parseInt($("#stock").val());
		$("#minus").on("click", function(){
			if(cntnum>1){
				cntnum-=1;
				$("#cnt_num").val(cntnum);
			}else{
				alert("더 이상 낮출 수 없습니다.");
			}
		});
		
		$("#plus").on("click", function(){
			if(stock>cntnum){
				cntnum+=1;
				$("#cnt_num").val(cntnum);
			}else{
				alert("더 이상 늘릴 수 없습니다.");
			}
		});
	});
</script>
<style>
div#maindiv{
	position: relative;
	top: 110px;
	background-color: #eeeeee;
	padding: 100px;
}
div#divimg{
	text-align: center;
}
div#msg{
	text-align: center;
}
div#btn{
	text-align: center;
}
img#cat{
	width: 200px;
}
div#footer{
	position: relative;
	top: 150px;
}
div#cart_list{
	border: 1px solid #dddddd;
	width: 600px;
	height: 200px;
	background-color: white;
	border-radius: 10px;
}
img#pimage{
	width: 100px;
}
div.form-check{
	margin-top: 30px;
	margin-left: 30px;
	width: 24px;
	float: left;
}
div#product_img{
	margin-right: 20px;
	width: 100px;
	height: 100px;
	float: left;
}
div#product_name{
	margin-top: 30px;
	margin-left: 30px;
}
div#p_num{
	width: 80px;
}
div#cart_product{
	border-bottom: 1px solid #dddddd;
	height: 120px;
}
</style>
<link rel="stylesheet" href="../css/order2.css" />
<link rel="stylesheet" href="../css/footer.css" />
</head>
<body>
<jsp:include page="../layout/header.html"></jsp:include>
<div id="maindiv">
	<%
	//현재 세션에서 cart의 속성 가져오기
	Object obj=session.getAttribute("cart");
	
	if(obj!=null){
		
		HashMap<Integer, Integer> list= (HashMap<Integer, Integer>)obj;
		
		
		ProductDAO dao=new ProductDAO();
		
		Set<Integer> set=list.keySet();
		Iterator<Integer> it=set.iterator();
		
		while(it.hasNext()){
			int key=it.next();
			ProductVO vo=dao.selectOne(key);
			int cnt=list.get(key);

	%>
	<div id="cart_list">
		<div id="cart_product">
			<div class="form-check">
  				<input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked>
  				<label class="form-check-label" for="flexCheckChecked"></label>
			</div>
			<input type="hidden" id="stock" value="<%=vo.getPstock() %>" />
			<a href="../detail?id=<%=vo.getPnum() %>">
				<div id="product_img"><img id="pimage" src="../<%=vo.getPthumbnail() %>" alt="" /></div>
				<div id="product_name"><%=vo.getPname() %></div>
			</a>
			<div id="p_num" class="input-group input-group-sm mb-3">
  				<button class="btn btn-outline-secondary" type="button" id="minus">-</button>
  				<input type="text" id="cnt_num" class="form-control" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1" value="<%=cnt %>" >
  				<button class="btn btn-outline-secondary" type="button" id="plus">+</button>
			</div>
		</div>
		<div id="charge">
			<span id="charge_msg">총 상품금액</span>
			<span id="charge_num"></span>
		</div>
	</div>
	<%
		}
	%>
		<div id="orderBtn">
			<a href="../order/order.jsp"><button type="button" class="btn btn-primary">결제하기</button></a>
		</div>
	
	<%
	}else{
	%>
		<div id="divimg">
			<img id="cat" src="../image/cat.png" alt="" />
		</div>
		<div id="msg">
			장바구니에 상품이 없습니다.
		</div>
		<div id="btn">
			<a href="store.jsp"><button type="button" class="btn btn-info">쇼핑하러 가기</button></a>
		</div>
	<%
	}
	%>
	</div>
<jsp:include page="../layout/footer.html"></jsp:include>
</body>
</html>