<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>鲸鱼鞋店</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<%@ include file="/inc/common_js_css.jsp.inc" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
<style type="text/css">
.carousel-inner .item img{
	max-height: 400px;
	max-width: 600px;
}
</style>
</head>
<body>
	<!-- 整个页面容器 -->
	<div class="container">
		<!-- 顶部 -->
		<%@ include file="/inc/header.jsp.inc" %>
		<!-- 轮播图部分 -->
		<div class="row carousel" id="carousel">
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
			      <img :src="products[0].imgUrl" :title="products[0].name" @click="jump(products[0].jumpUrl)">
			    </div>
			    <div class="item">
			      <img :src="products[1].imgUrl" :title="products[1].name" @click="jump(products[1].jumpUrl)">
			    </div>
			    <div class="item">
			      <img :src="products[2].imgUrl" :title="products[2].name" @click="jump(products[2].jumpUrl)">
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
		<%@ include file="/inc/footer.jsp.inc" %>
	</div>
</body>
<script type="text/javascript">
	var hotProduct = ${hotProduct};
	new Vue({
		el:"#carousel",
		data:function(){
			return {
				products: hotProduct,
				useDiscount:true,
			};
		},
		methods: {
			jump: function(url){
				window.location.href = url;
			},
		}
	}); 
	new Vue({
		el:"#hotProduct",
		data:function(){
			return {
				products: hotProduct,
				useDiscount:true,
			};
		},
	});
	
	new Vue({
		el:"#newProduct",
		data:function(){
			return {
				products:${newProduct}
			};
		},
	});
</script>
</html>