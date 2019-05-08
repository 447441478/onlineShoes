<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/inc/common_js_css_inc.jsp" />
<script type="text/javascript" src="${APP_DIR}/js/md5.js" charset="utf-8"></script>
<title>会员中心</title>
<style type="text/css">
.top_bar{
	position: relative;
    left: 0;
    top: 0;
    width: 100%;
    box-sizing:border-box;
    padding: 0 40px;
    border-bottom: 1px solid rgb(233, 235, 240); 
}
.top_bar_title{
	line-height: 64px;
    font-size: 18px;
    color: #5874d8;
    font-weight: normal;
    display: inline-block;
    cursor: default;
}
/*//////////////////////////////////////////*/
.menu{
	text-align: center;
	height: 400px;
	border: 1px solid;
	box-sizing: border-box;
	padding: 0;
	background-color: #6791b5;
}
.menu .item{
	color: #fff;
	height: 32px;
	line-height:32px;
	font-size: 16px;
	cursor: pointer;
}
.menu .item:hover{
	background-color: #2395f7;
}
.menu .active{
	background-color: #ef14a2;
}
</style>
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">会员中心</div>
	</div>
	<div class="container-fluid" id="memberCenter">
		<div class="row" style="padding: 16px">
			<div class="col-xs-3 menu">
				<div class="item active">我的地址</div>
				<div class="item">修改密码</div>
			</div>
			<div class="col-xs-8">2222222222222</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var memberCenter = new Vue({
	el:"#memberCenter",
});
</script>
</html>