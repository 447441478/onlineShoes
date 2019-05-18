<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<title>鲸鱼鞋店</title>
<%@ include file="/inc/common_js_css.jsp.inc" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/shoesList.css">
</head>
<body>
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<%@ include file="/inc/header.jsp.inc" %>
		<div id='b-products' style="margin-top:20px;">
			<products-component :products="products"></products-component>
			<div class="row"></div>
			<div class="row" style="text-align: center;">
				<products-pagination :page-info="pageInfo"></products-pagination>
			</div>
		</div>
		<!-- 底部 -->
		<%@ include file="/inc/footer.jsp.inc" %>
	</div>
</body>
<script type="text/javascript">
(function(){
	var brandId = ${empty brandId ? -1:brandId};
	var keyWord = "${empty keyWord ? "":keyWord}";
	var pageSize = 16;
	new Vue({
		el:"#b-products",
		data:function(){
			return{
				pageInfo:{
					currentPage:1,
					total:0,
					pageSize:pageSize,
				},
				products:[],
			}
		},
		watch:{
			'pageInfo.currentPage':function(val){
				var that = this;
				$.ajax({
					url:"${APP_DIR}/products",
					data:{
						brandId:brandId,
						currentPage:val,
						pageSize:pageSize,
						keyWord:keyWord,
					},
					type:"get",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							that.pageInfo.total = msg.datas.total;
							that.products = msg.datas.products;
							window.location.hash="#p="+val;
						}else{
							
						}
					}
				});
			}
		},
		created:function(){
			var that = this;
			$.ajax({
				url:"${APP_DIR}/products",
				data:{
					brandId:brandId,
					currentPage:1,
					pageSize:pageSize,
					keyWord:keyWord,
				},
				type:"get",
				asycn:false, //同步请求
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						that.pageInfo.total = msg.datas.total;
						that.products = msg.datas.products;
					}else{
						
					}
				}
			});
		}
	});
})();
</script>
</html>