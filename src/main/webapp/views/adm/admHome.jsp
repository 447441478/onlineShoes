<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@page import="net.hncu.onlineShoes.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
<title>后台管理</title>
<jsp:include page="/inc/admCommon_js_css_inc.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/home.css">
<style type="text/css">
.admTitle{
    display: inline-block;
    border-collapse: separate;
    cursor: pointer;
    font-size: 32px;
    font-weight: 700;
    white-space: nowrap;
    position: absolute;
    width: 200px;
    height: 42px;
    line-height: 42px;
    text-align: center;;
    top: 50%;
    left: 50%;
    margin-left: -100px;
    margin-top: -21px;
    cursor: default;
}
.topBar{
	float: right;
	margin-top: 27px;
	margin-right: 20px;
}
.topDate{
	float: left;
    margin-top: 27px;
    margin-left: 20px;
}
</style>
</head>
<body style="margin: 0;padding: 0;">
	<div class="easyui-layout" style="width:100%;height:100%">
		<div data-options="region:'north'" style="height:80px">
			<div class="admTitle">后台管理系统</div>
			<div class="topBar">
				欢迎您，${user.username}&ensp;
				<a href="javascript:;" onclick="logout()">安全退出</a>
			</div>
			<div class="topDate"></div>
		</div>
		<div id="funPanel" data-options="region:'west',split:true" title="后台管理" style="width:180px;">
			<div id="funs" class="easyui-sidemenu"></div>
		</div>
		<div data-options="region:'center'">
			<iframe id="manageFramePage" src="" style="width: 100%;height: 100%" frameborder=0 scrolling="yes"></iframe>
		</div>

	</div>

</body>
<script type="text/javascript">
var manageFramePreUrl = "${pageContext.request.contextPath}/adm/";
var data = [];
var flag = ${user.flag};
if((flag & <%=User.Flag.PRODUCT_MANAGER%>) == <%=User.Flag.PRODUCT_MANAGER%>){
	data.push({
	    text: '产品',
	    state: 'open',
	    children: [{
	        text: '添加产品<input type="hidden" value="product/add"/>'
	    },{
	        text: '管理产品<input class="defaultMenu" type="hidden" value="product/manage"/>',
	    }]
	});
}
if((flag & <%=User.Flag.ORDER_MANAGER%>) == <%=User.Flag.ORDER_MANAGER%>){
	data.push({
	    text: '订单',
	    children: [{
	        text: '管理订单<input class="defaultMenu" type="hidden" value="order/manageOrder"/>'
	    }]
	});
}
if((flag & <%=User.Flag.MEMBER_MANAGER%>) == <%=User.Flag.MEMBER_MANAGER%>){
	data.push({
	    text: '会员',
	    children: [{
	        text: '管理会员<input class="defaultMenu" type="hidden" value="member/manageMember"/>'
	    }]
	});
}
var funs = $("#funs").sidemenu({
	data:data,
	width:173,
	onSelect:function(item){
		var url = manageFramePreUrl+$(item.target).find("input").val();
		$("#manageFramePage").attr("src",url);
	}
});
 
$(function(){
	$(".defaultMenu").eq(0).parent("span").click();
	var str = new Date().Format("yyyy-MM-dd hh:mm:ss");
	$(".topDate").text("当前时间："+str);
	setInterval(function(){
		var str = new Date().Format("yyyy-MM-dd hh:mm:ss");
		$(".topDate").text("当前时间："+str);
	},1000);
})
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
</script>
</html>