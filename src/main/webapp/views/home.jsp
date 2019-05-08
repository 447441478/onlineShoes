<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>鲸鱼鞋店</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<jsp:include page="/inc/common_js_css_inc.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<jsp:include page="/inc/header_inc.jsp" />
		<!-- 轮播图部分 -->
		<div class="row carousel">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel" data-interval="2000">
			  <!-- Indicators -->
			  <ol class="carousel-indicators">
			    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
			    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
			  </ol>
			
			  <!-- Wrapper for slides -->
			  <div class="carousel-inner" role="listbox">
			    <div class="item active">
			      <img src="${pageContext.request.contextPath}/img/banner1.jpg" alt="...">
			    </div>
			    <div class="item">
			      <img src="${pageContext.request.contextPath}/img/banner2.jpg" alt="...">
			    </div>
			    <div class="item">
			      <img src="${pageContext.request.contextPath}/img/banner3.jpg" alt="...">
			    </div>
			  </div>
			
			  <!-- Controls -->
			  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>			
		</div>
		<!-- 热销商品 -->
		<div class='row myHotProduct'>
			<div id="hotProduct">
				<div class="col-md-12 title">热门商品</div>
				<products-component :products="products"></products-component>
			</div>
		</div>
		<!-- 最新商品 -->
		<div class='row myNewProduct'>
			<div id="newProduct">
				<div class="col-md-12 title">最新商品</div>
				<products-component :products="products"></products-component>
			</div>
		</div>
		<!-- 底部 -->
		<jsp:include page="/inc/footer_inc.jsp" />
	</div>
</body>
<script type="text/javascript">
	new Vue({
		el:"#hotProduct",
		data:function(){
			return {
				products:[
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99,
						discountPrice:120,
						useDiscount:true,
						priceStyle:"discounPrice"
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99,
						discountPrice:120
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99,
						discountPrice:120
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99,
						discountPrice:120
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99,
						discountPrice:120
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99,
						discountPrice:120
					},
				],
				useDiscount:true,
			};
		},
	});
	new Vue({
		el:"#newProduct",
		data:function(){
			return {
				products:[
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99
					},
					{
						imgUrl:"img/product/pic.jpg",
						jumpUrl:"#",
						name:"新百伦新百伦新百伦新百伦新百伦新百伦新百伦新百伦",
						price:199.99
					},
				]
			};
		},
	});
</script>
</html>