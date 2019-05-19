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
<title>登录</title>
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
#login .input-group span{
	background: #fff;
	border: none;
}
#login .input-group input {
	-webkit-box-shadow: 0 0 0px 1000px #fff inset;
	-moz-box-shadow: 0 0 0px 1000px #fff inset;
	-ms-box-shadow: 0 0 0px 1000px #fff inset;
	border: none;
    border-radius: unset;
}
#login .input-group{
	border: 1px solid #ddd;
}
.loginBtn{
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
#login .error,.success{
	font-size: 12px;
}
#login .tooltip .right{
	width: 100px;
}
.forgetPwd{
	float: right;color: #4c6083;border:none;
}
</style>
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">用户登录</div>
	</div>
	<div class="container-fluid" id="login">
		<form action="" autocomplete="off">
			<div class="row" style="height: 36px;line-height: 36px; margin-top: 48px;">
				<div class="col-xs-5 col-xs-offset-3">
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon-name"><i class="glyphicon glyphicon-home" style="color: #5bc0de;"></i></span>
					  <input id="username" ref="username" name="username" @change="checkUsername()" type="text" 
					  	v-model="username" class="form-control" placeholder="账号/邮箱" 
					  	aria-describedby="sizing-addon-name" AUTOCOMPLETE="off" />
					</div>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_1 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的账号/邮箱
					</span>
					<div class="success" v-show="msg_1 == 2">
						<i class="glyphicon glyphicon-ok-sign" ></i>&nbsp;
					</div>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 36px;">
				<div class="col-xs-5 col-xs-offset-3">
					<div class="input-group">
					  <span class="input-group-addon" id="sizing-addon-pwd"><i class="glyphicon glyphicon-lock"  style="color: #d9534f;"></i></span>
					  <input id="password" name="password" @keyup.enter='login()' @change="checkPassword()" type="password" 
					  	v-model="password" class="form-control" placeholder="密码" 
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
			<div v-if="errorLoginNum >= 3" class="row" style="height: 36px;line-height: 36px;margin-top: 36px;">
				<div class="col-xs-5 col-xs-offset-3">
					<div class="input-group" style="border:none;">
					  <input id="checkCode" style="border:1px solid #ddd;" name="checkCode" @keyup.enter='login()' @change="checkCheckCode()" type="text"
					  	v-model="checkCode" class="form-control" placeholder="验证码" 
					  	aria-describedby="sizing-addon-checkCode" AUTOCOMPLETE="off" />
					  <span style="padding: 2.5px 10px;" class="input-group-addon" id="sizing-addon-checkCode">
					  	<img @click="changeCheckCode()" alt="" :src="checkCodeUrl" style="margin-right: 10px;cursor: pointer;">
					  	<i @click="changeCheckCode()" class="glyphicon glyphicon-repeat" style="cursor: pointer;" title="看不清？点击换一张"></i>
					  </span>
					</div>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_3 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入4位数验证码
					</span>
					<span class="success" v-show="msg_3 == 2">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;
					</span>
				</div>
			</div>
			<div class="row" style="margin-top: 6px;">
				<div class="col-xs-5 col-xs-offset-3">
					 <div class="checkbox">
				        <label>
				          <input type="checkbox" v-model="autoLogin">两周内自动登录
				        </label>
				        <a class="forgetPwd" href="forgetPwd">忘记密码？</a>
				      </div>
				      
				</div>
			</div>
			<div class="row" style="height: 40px;line-height: 40px;margin-top: 8px;">
				<div class="col-xs-5 col-xs-offset-3" style="text-align: center;">
					<div @click.stop='login()' class="loginBtn">登录</div>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 8px;">
				<div class="col-xs-5 col-xs-offset-3" style="text-align: center;">
					还没有账号？<a href="regist">立即注册</a>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
var login = new Vue({
	el:"#login",
	data:function(){
		return{
			username:"",
			msg_1:0,
			password:"",
			msg_2:0,
			checkCode:"",
			msg_3:0,
			checkCodeUrl:"checkCode",
			errorLoginNum:${errorLoginNum == null ? 0 : errorLoginNum},
			autoLogin:false,
		};
	},
	methods:{
		changeCheckCode:function(){
			this.checkCodeUrl = "checkCode?t=" + new Date().getTime();
		},
		checkUsername:function(){
			var username = this.username;
			var reg = /^\w{3,20}$/;
			if(!reg.test(username)){
				this.msg_1 = 1;
				return false;
			}
			this.msg_1 = 2;
			return true;
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
		checkCheckCode:function(){
			var checkCode = this.checkCode;
			var reg =/^[0-9a-zA-z]{4}$/;
			if(!reg.test(checkCode)){
				this.msg_3 = 1;
				return false;
			}
			this.msg_3 = 2;
			return true;
		},
		login:function(){
			if(this.msg_1 == 2 && this.msg_2 == 2 && (this.msg_3 == 2 || this.errorLoginNum < 3)){
				var that = this;
				$.ajax({
					url:"${APP_DIR}/user/login",
					data:{
						username:that.username,
						password:md5(that.password),
						checkCode:that.checkCode,
						autoLogin:that.autoLogin,
					},
					type:"POST",
					success:function(msg){
						if(msg.code == <%=Msg.Code.SUCCESS%>){
							if(that.autoLogin){
								$.cookie("username",that.username,{expires:14,path:"/"});
								$.cookie("password",md5(that.password),{expires:14,path:"/"});
							}
							var prePath = $.cookie("prePath") || "";
							if(prePath != ""){
								$.removeCookie("prePath",{path:"/"});
								top.location.href = prePath;
							}else{
								top.location.reload();
							}
						}else{
							that.errorLoginNum++;
						}
						alert(msg.info);
					}
				});
			}
		},
	},
	watch:{
		errorLoginNum:function(val){
			if(val>3){
				this.changeCheckCode();
			}
		}
	},
	mounted: function(){
		var that = this;
		setTimeout(function(){
			that.$refs.username.focus();
		},500);
	},
	created: function(){
		
	},

});
</script>
</html>