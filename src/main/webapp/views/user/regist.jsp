<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	application.setAttribute("APP_DIR", request.getContextPath());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/inc/common_js_css.jsp.inc" %>
<script type="text/javascript" src="${APP_DIR}/js/md5.js" charset="utf-8"></script>
<title>注册</title>
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
#regist .input-group span{
	background: #fff;
	border: none;
}
#regist .input-group input {
	-webkit-box-shadow: 0 0 0px 1000px #fff inset;
	-moz-box-shadow: 0 0 0px 1000px #fff inset;
	-ms-box-shadow: 0 0 0px 1000px #fff inset;
	border: none;
    border-bottom: 1px solid #ddd;
    border-radius: unset;
}
.registBtn{
	height: 36px;
    line-height: 36px;
    background-color: #0075ff;
    border-radius: 2px;
    color: #fff;
    text-align: center;
    font-size: 16px;
    outline: 0;
    border: 0;
    cursor: pointer;
}

a{
	outline: 0;
	margin: 0;
    padding: 0;
	color: #0075ff;
    display: inline-block;
    height: 17px;
    line-height:17px;
    cursor:pointer;
    border-bottom: 1px solid #0075ff;
    text-decoration: none;
}
a:hover{
	color: #00a1ff;
	border-bottom-color:#00a1ff;
    text-decoration: none;
}
.error{
	color: #fa5b5b;
}
.success{
	color:#71c86f;
}
.success i{
	position: relative;
}
#regist .error,.success{
	font-size: 12px;
}
</style>
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">用户注册</div>
	</div>
	<div class="container-fluid" id="regist">
		<form action="" autocomplete="off">
			<div class="row" style="height: 36px;line-height: 36px; margin-top: 36px;">
				<div class="col-xs-6 col-xs-offset-2">
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon-name">账号<!-- <i class="glyphicon glyphicon-home" style="color: #5bc0de;"></i> --></span>
					  <input id="username" name="username" @change="checkUsername()" type="text" 
					  	v-model="username" class="form-control" placeholder="3-20个字符，区分大小写" 
					  	aria-describedby="sizing-addon-name" AUTOCOMPLETE="off" />
					</div>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_1 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的账号
					</span>
					<div class="success" v-show="msg_1 == 2">
						<i class="glyphicon glyphicon-ok-sign" ></i>&ensp;正在检查账号是否可用...
					</div>
					<div class="error" v-show="msg_1 == 3">
						<i class="glyphicon glyphicon-remove-sign" ></i>&ensp;很抱歉，该账号已被注册。
					</div>
					<div class="success" v-show="msg_1 == 4">
						<i class="glyphicon glyphicon-ok-sign" ></i>&nbsp;
					</div>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 36px;">
				<div class="col-xs-6 col-xs-offset-2">
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon-pwd">密码<!-- <i class="glyphicon glyphicon-lock"  style="color: #d9534f;"></i> --></span>
					  <input id="password" name="password" @change="checkPassword()" type="password" 
					  	v-model="password" class="form-control" placeholder="3-20个字符，区分大小写" 
					  	aria-describedby="sizing-addon-pwd" AUTOCOMPLETE="new-password" />
					</div>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_2 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的密码
					</span>
					<span class="success" v-show="msg_2 == 2">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;
					</span>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 36px;">
				<div class="col-xs-6 col-xs-offset-2">
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon-email">邮箱<!-- <i class="glyphicon glyphicon-envelope"  style="color: #4a5d76;"></i> --></span>
					  <input id="email" name="email" @change="checkEmail()" type="email"
					  	v-model="email" class="form-control" placeholder="请输入电子邮箱" 
					  	aria-describedby="sizing-addon-email" AUTOCOMPLETE="off" />
					</div>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_3 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的邮箱
					</span>
					<span class="success" v-show="msg_3 == 2">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;
					</span>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 36px;">
				<div class="col-xs-4 col-xs-offset-3" style="text-align: center;">
					<div @click.stop='regist()' class="registBtn">免费注册</div>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 16px;">
				<div class="col-xs-4 col-xs-offset-3" style="text-align: center;">
					已有账号？<a href="login" style="">直接登录</a>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
var v_regist = new Vue({
	el:"#regist",
	data:function(){
		return{
			username:"",
			msg_1:0,
			password:"",
			msg_2:0,
			email:"",
			msg_3:0,
		};
	},
	watch:{
	},
	methods:{
		checkUsername:function(){
			var username = this.username;
			var reg = /^\w{3,20}$/;
			if(!reg.test(username)){
				this.msg_1 = 1;
				return false;
			}
			var that = this;
			$.ajax({
				url:"${APP_DIR}/user/check",
				data:{
					username:username
				},
				type:"GET",
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						that.msg_1 = 4;
					}else{
						that.msg_1 = 3;
					}
				}
			});
			this.msg_1 = 2;
			return false;
		},
		checkPassword:function(){
			var password = this.password;
			var reg = /^\w{3,20}$/;
			if(!reg.test(password)){
				this.msg_2 = 1;
				return false;
			}
			this.msg_2 = 2;
			return true;
		},
		checkEmail:function(){
			var email = this.email;
			var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
			if(!reg.test(email)){
				this.msg_3 = 1;
				return false;
			}
			this.msg_3 = 2;
			return true;
		},
		regist:function(){
			if(this.msg_1 == 4 && this.msg_2 == 2 && this.msg_3 == 2){
				var that = this;
				$.ajax({
					url:"${APP_DIR}/user/regist",
					data:{
						username:that.username,
						password: md5(that.password),
						email:that.email,
					},
					type:"POST",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							alert(msg.info);
						}else{
							alert("注册信息有误");
						}
					}
				});
			}
		}
	},
	create:function(){
	}
});

</script>
</html>