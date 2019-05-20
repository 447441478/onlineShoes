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
    </head>
    <body>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <blockquote class="layui-elem-quote">欢迎管理员：
                                <span class="x-red">${user.username}</span>！<span class="topDate"></span>
                                
                            </blockquote>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">数据统计</div>
                        <div class="layui-card-body ">
                            <ul class="layui-row layui-col-space10 layui-this x-admin-carousel x-admin-backlog">
                                <li class="layui-col-md3 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>产品数</h3>
                                        <p>
                                            <cite>${shoesTotal}</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md3 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>会员数</h3>
                                        <p>
                                            <cite>${userTotal}</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md3 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>订单数</h3>
                                        <p>
                                            <cite>${orderDetailTotal}</cite></p>
                                    </a>
                                </li>
                                <li class="layui-col-md3 layui-col-xs6">
                                    <a href="javascript:;" class="x-admin-backlog-body">
                                        <h3>评论数</h3>
                                        <p>
                                            <cite>${commentTotal}</cite></p>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">系统信息</div>
                        <div class="layui-card-body ">
                            <table class="layui-table">
                                <tbody>
                                    <tr>
                                        <th>版本</th>
                                        <td>1.0</td></tr>
                                    <tr>
                                        <th>服务器地址</th>
                                        <td>onlineShoes.hncu.net</td></tr>
                                    <tr>
                                        <th>操作系统</th>
                                        <td>Windows8</td></tr>
                                    <tr>
                                        <th>运行环境</th>
                                        <td>Tomcat7.0</td></tr>
                                    <tr>
                                        <th>JAVA版本</th>
                                        <td>1.7</td></tr>
                                        <th>MYSQL版本</th>
                                        <td>5.7</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">开发团队</div>
                        <div class="layui-card-body ">
                            <table class="layui-table">
                                <tbody>
                                    <tr>
                                        <th>版权所有</th>
                                        <td>Whale
                                            <a href="${APP_DIR}/" target="_blank">访问官网</a></td>
                                    </tr>
                                    <tr>
                                        <th>开发者</th>
                                        <td>宋进宇(447441478@qq.com)</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <style id="welcome_style"></style>
        </div>
        </div>
    </body>
    <script type="text/javascript">
	var str = new Date().Format("yyyy-MM-dd hh:mm:ss");
	$(".topDate").text("当前时间："+str);
	setInterval(function(){
		var str = new Date().Format("yyyy-MM-dd hh:mm:ss");
		$(".topDate").text("当前时间："+str);
	},1000);
    </script>
</html>