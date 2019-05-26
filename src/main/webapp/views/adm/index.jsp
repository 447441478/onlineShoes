<%@page import="net.hncu.onlineShoes.domain.User"%>
<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<!doctype html>
<html class="x-admin-sm">
    <head>
        <meta charset="UTF-8">
        <title>后台管理</title>
        <meta name="renderer" content="webkit|ie-comp|ie-stand">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
        <meta http-equiv="Cache-Control" content="no-siteapp" />
       	<link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.jpg" type="image/x-icon" />
       	<%@ include file="/inc/admCommon_js_css.jsp.inc" %>
        <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
        <!--[if lt IE 9]>
          <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
          <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script>
            // 是否开启刷新记忆tab功能
            var is_remember = false;
        </script>
    </head>
    <body class="index">
        <!-- 顶部开始 -->
        <div class="container">
            <div class="logo">
                <a href="#">后台管理系统</a></div>
            <div class="left_open">
                <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
            </div>
            <ul class="layui-nav right" lay-filter="">
                <li class="layui-nav-item">
                    <a href="javascript:;">${user.username}</a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a onclick="xadmin.open('切换帐号','${APP_DIR}/user/login',600,600);$.cookie('prePath','${APP_DIR}/adm',{path:'/'});">切换帐号</a>
                        </dd>
                        <dd>
                            <a href="javascript:;" onclick="logout()">退出</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item to-index">
                    <a href="${APP_DIR}/">前台首页</a></li>
            </ul>
        </div>
        <!-- 顶部结束 -->
        <!-- 中部开始 -->
        <!-- 左侧菜单开始 -->
        <div class="left-nav" id="admHome">
            <div id="side-nav">
                <ul id="nav">
                    <li v-if="(flag & <%=User.Flag.PRODUCT_MANAGER%>) == <%=User.Flag.PRODUCT_MANAGER%>">
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="产品">&#xe6b4;</i>
                            <cite>产品</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <li>
                                <a onclick="xadmin.add_tab('添加产品','${APP_DIR}/adm/product/add?showRefresh=true')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>添加产品</cite>
                                </a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('管理产品','${APP_DIR}/adm/product/manage')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>管理产品</cite>
                                </a>
                            </li>
                            <li>
                                <a onclick="xadmin.add_tab('产品评论','${APP_DIR}/adm/product/manegeComment')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>产品评论</cite>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li v-if="(flag & <%=User.Flag.ORDER_MANAGER%>) == <%=User.Flag.ORDER_MANAGER%>">
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="订单">&#xe723;</i>
                            <cite>订单</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <li>
                                <a onclick="xadmin.add_tab('管理订单','${APP_DIR}/adm/order/manageOrder')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>管理订单</cite>
                                </a>
                            </li>
                        </ul>
                    </li>
                   	<li v-if="(flag & <%=User.Flag.MEMBER_MANAGER%>) == <%=User.Flag.MEMBER_MANAGER%>">
                        <a href="javascript:;">
                            <i class="iconfont left-nav-li" lay-tips="会员">&#xe6b8;</i>
                            <cite>会员</cite>
                            <i class="iconfont nav_right">&#xe697;</i></a>
                        <ul class="sub-menu">
                            <li>
                                <a onclick="xadmin.add_tab('管理会员','${APP_DIR}/adm/member/manageMember')">
                                    <i class="iconfont">&#xe6a7;</i>
                                    <cite>管理会员</cite>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!-- <div class="x-slide_left"></div> -->
        <!-- 左侧菜单结束 -->
        <!-- 右侧主体开始 -->
        <div class="page-content">
            <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
                <ul class="layui-tab-title">
                    <li class="home">
                        <i class="layui-icon">&#xe68e;</i>
                       	我的桌面
                    </li>
                 </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <iframe src='${APP_DIR}/adm/welcome' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
                    </div>
                </div>
                <div id="tab_show"></div>
            </div>
        </div>
        <div class="page-content-bg"></div>
        <style id="theme_style"></style>
        <!-- 右侧主体结束 -->
        <!-- 中部结束 -->
    </body>
<script type="text/javascript">
	var v_admHome = new Vue({
		el:"#admHome",
		data: function(){
			return {
				flag: ${user.flag}
			}
		}
	});
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