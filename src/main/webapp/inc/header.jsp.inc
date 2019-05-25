<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/header.css" />

<div class="myTopBar">
<ul class="layui-nav funs" lay-filter="topBar">
<c:if test="${empty user}" var="boo">
	<li class="layui-nav-item">
		<a href="javascript:;" onclick="login();">登录</a>
	</li>
	<li class="layui-nav-item">
		<a href="javascript:;" onclick="regist();">注册</a>
	</li>
</c:if>
<!--	<li class="layui-nav-item">
		<a href="javascript:addFavorite();" rel="sidebar" class="layui-icon layui-icon-star"> 收藏本站</a>
	</li>-->
	<li class="layui-nav-item shoppingCar">
		<a href="javascript:;" onclick="shoppingCar()" class="layui-icon layui-icon-cart"> 购物车</a>
	</li>
	<li class="layui-nav-item myOrder">
		<a href="javascript:;" onclick="myOrder()" class="layui-icon layui-icon-list"> 我的订单</a>
	</li>
<c:if test="${!boo}" var="boo">
	<li class="layui-nav-item" lay-unselect="" >
		<a href="javascript:;" class="layui-icon layui-icon-username"> ${user.username}</a>
		<dl class="layui-nav-child second" >
			<dd><a href="javascript:;" onclick="memberCenter()" class="layui-icon layui-icon-rate"> 会员中心</a></dd>
			<dd><a href="javascript:;" onclick="logout()" style="color: #00a1ff;">[退出]</a></dd>
		</dl>
	</li>
</c:if>
</ul>
</div>
<div class="row myTop">
	<div class="col-md-4 col-md-offset-4 myTitle" onclick="location.href='${APP_DIR}/'"> Whale Shoes Store</div>
</div>
<div id='myNav' v-if="isShow" class="row myNav">
	<div v-for="nav in navs" class="col-md-1 item" :class="[nav.brandid==activeBrandId?'active':'']" @click="getProductList(nav.brandid)">{{nav.name}}</div>
	<div class="col-md-3 col-md-offset-3 item" >
		<div class="input-group mySearch">
		  <input @keyup.enter="search()" v-model="keyWord" type="text" class="form-control" placeholder="搜索内容" aria-describedby="sizing-addon2">
		  <span @click.stop="search()" class="input-group-addon" id="sizing-addon2" >
		  	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
		  </span>
		</div>
	</div>
</div>
<!-- 模式对话框 -->
<div class="modal fade" id="myModal" style="overflow:hidden;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="dialog" style="width: 600px;height: 500px;">
		<div class="modal-content">
			<button style="position: relative;right: 20px;top: 20px;z-index: 100;" type="button" class="close" data-dismiss="modal" aria-hidden="true">
				&times;
			</button>
			<div class="modal-body" style="width: 600px;height: 500px;padding: 0px;">
				<iframe src="" style="width: 100%;height: 100%;position: fixed;border-radius: 5px;" frameborder=0 scrolling="yes"></iframe>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>		
<script type="text/javascript">
//添加收藏
function addFavorite() {
	var url = window.location;
	var title = document.title;
	var ua = navigator.userAgent.toLowerCase();
	if (ua.indexOf("msie 8") > -1) {
		external.AddToFavoritesBar(url, title, '');//IE8
	} else {
		try {
			window.external.addFavorite(url, title);
		} catch (e) {
			try {
				window.sidebar.addPanel(title, url, "");//firefox
			} catch (e) {
				alert("加入收藏失败，请使用Ctrl+D进行添加");
			}
		}
	}
}

	function myOrder(){
		var url = "${APP_DIR}/order";
		if(${empty user}){
			$.cookie("prePath",url,{path:"/"});
			login();
		}else{
			window.location.href = url;
		}
	}

	function shoppingCar(){
		var url = "${APP_DIR}/basket";
		if(${empty user}){
			$.cookie("prePath",url,{path:"/"});
			login();
		}else{
			window.location.href = url;
		}
	}
	function memberCenter(e){
		if(${empty user}){
			login();
		}else{
			$("#myModal iframe").attr("src","${APP_DIR}/user/memberCenter");
			$('#myModal').modal("show");
		}
	}
	function logout(){
		$.ajax({
			url:"${APP_DIR}/user/logout",
			type:"get",
			success:function(msg){
				if(msg.code == <%=Msg.Code.SUCCESS%>){
					$.removeCookie("password",{expires:-1,path:"/"});
					alert(msg.info);
					window.location.reload();
				}
			}
		});
	}
	function login() {
		$("#myModal iframe").attr("src","${APP_DIR}/user/login");
		$('#myModal').modal("show");
	}
	function regist(){
		$("#myModal iframe").attr("src","${APP_DIR}/user/regist");
		$('#myModal').modal("show");
	}
	var nav = new Vue({
		el:"#myNav",
		data:function(){
			return{
				isShow:true,
				navs:[],
				activeBrandId:${brandId == null ? 0:brandId},
				keyWord:"${keyWord}",
			};
		},
		methods:{
			getProductList:function(brandid){
				if(brandid == 0){
					location.href = "${APP_DIR}/";
					return;
				}
				location.href="${APP_DIR}/brand/"+brandid;
			},
			search:function(){
				var keyWord = this.keyWord;
				if(keyWord == ""){
					alert("搜索内容不能为空。");
					return;
				}
				location.href="${APP_DIR}/products/search?keyWord="+encodeURIComponent(keyWord);
			},
		},
		created:function(){
			var that = this;
			$.ajax({
				async:false, //同步请求
				url:"${APP_DIR}/brands",
				type:"get",
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						that.navs = msg.datas.brands;
					}
				}
			});
		}
	});
	$(function () {
		layui.use('element', function(){
			var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
		});


		////////////////////////////////
		$(".funs li").on("click",function () {

			$(this).removeClass("layui-this");
		});
		$(".funs li dl dd").on("click",function () {
			$(this).removeClass("layui-this");
			if(location.pathname == "/basket"){
				$(".funs .shoppingCar").addClass("layui-this");
				return ;
			}
			if(location.pathname == "/order"){
				$(".funs .myOrder").addClass("layui-this");
				return ;
			}
		});
	});

</script>