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
<title>找回密码</title>
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
#forgetPwd span{
	background: #fff;
	border: none;
}
#forgetPwd input {
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
.error,.success{
	font-size: 12px;
}
#forgetPwd .item_code{
	display: inline-block;
    text-align: center;
    width: 102px;
    height: 28px;
    line-height: 26px;
    border: 1px solid #a7cfff;
    background-color: #fff;
    color: #4e9fff;
    border-radius: 2px;
    cursor: pointer;
    float: right;
    position: absolute;
    right: 4px;
    margin-right: -4px;
}
#forgetPwd .item_code:hover{
    border-color: #4f9fff;
    background-color: #4f9fff;
    color: #fff;
}
#forgetPwd .item_code_1{
	display: inline-block;
    text-align: center;
    width: 102px;
    height: 28px;
    line-height: 26px;
    border: 1px solid #eee;
    background-color: #fff;
    color: #888;
    border-radius: 2px;
    float: right;
    position: absolute;
    right: 4px;
    margin-right: -4px;
}
</style>
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">找回密码</div>
	</div>
	<div class="container-fluid" id="forgetPwd">
		<form action="" autocomplete="off">
			<div class="row" style="height: 36px;line-height: 36px; margin-top: 36px;">
				<div style="text-align: right;padding-right: 0;" class="col-xs-3">账号</div>
				<div class="col-xs-5">
					  <input name="username" @change="checkUsername()" type="text" 
					  	v-model="username" class="form-control" placeholder="3-20个字符，区分大小写"  
					  	/>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_0 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的账号
					</span>
					<span class="success" v-show="msg_0 == 2">
						<i class="glyphicon glyphicon-ok-sign" ></i>&ensp;正在检查账号是否存在...
					</span>
					<span class="error" v-show="msg_0 == 3">
						<i class="glyphicon glyphicon-remove-sign" ></i>&ensp;很抱歉，该账号不存在。
					</span>
					<span class="success" v-show="msg_0 == 4">
						<i class="glyphicon glyphicon-ok-sign" ></i>&nbsp;
					</span>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px; margin-top: 36px;">
				<div style="text-align: right;padding-right: 0;" class="col-xs-3">新密码</div>
				<div class="col-xs-5">
					  <input name="password" @change="checkPassword()" type="password" 
					  	v-model="password" class="form-control" placeholder="3-20个字符，区分大小写" 
					  	/>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_1 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的密码
					</span>
					<span class="success" v-show="msg_1 == 2">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;
					</span>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px; margin-top: 36px;">
				<div style="text-align: right;padding-right: 0;" class="col-xs-3">确认密码</div>
				<div class="col-xs-5">
					  <input name="password2" @change="checkPassword2()" type="password" 
					  	v-model="password2" class="form-control" placeholder="3-20个字符，区分大小写" 
					  	/>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_2 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;请输入正确的密码
					</span>
					<span class="error" v-show="msg_2 == 2">
						<i class="glyphicon glyphicon-remove-sign"></i>&ensp;两次密码不一致
					</span>
					<span class="success" v-show="msg_2 == 3">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;
					</span>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px; margin-top: 36px;">
				<div style="text-align: right;padding-right: 0;" class="col-xs-3">邮箱验证码</div>
				<div class="col-xs-3">
					  <input name="emailCode"  type="text" 
					  	v-model="emailCode" class="form-control" />
				</div>
				<div class="col-xs-2">
					<span class='item_code' v-if='canSendEmailCode' @click='getEmailCode()'>获取验证码</span>
					<span class='item_code_1' v-else>重新获取({{seconds}})</span>
				</div>
				<div class="col-xs-4">
					<span class="error" v-show="msg_3 == 1">
						<i class="glyphicon glyphicon-remove-sign"></i>&nbsp;系统繁忙，请稍后再试。
					</span>
					<span class="success" v-show="msg_3 == 2">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;已发送到邮箱
					</span>
					<span class="error" v-show="msg_3 == 3">
						<i class="glyphicon glyphicon-ok-sign"></i>&nbsp;验证码不能为空
					</span>
				</div>
			</div>
			<div class="row" style="height: 36px;line-height: 36px;margin-top: 36px;">
				<div class="col-xs-4 col-xs-offset-3" style="text-align: center;">
					<div @click.stop='findBack()' class="registBtn">马上找回</div>
				</div>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	var v_forgetPwd = new Vue({
		el:"#forgetPwd",
		data: function(){
			return {
				username: '',
				msg_0: '',
				password: '',
				msg_1: '',
				password2: '',
				msg_2: '',
				emailCode: '',
				msg_3: '',
				canSendEmailCode: true,
				seconds:60,
				timer:{},
			}
		},
		methods:{
			checkUsername: function(){
				var username = this.username;
				var reg = /^\w{3,20}$/;
				if(!reg.test(username)){
					this.msg_0 = 1;
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
							that.msg_0 = 3;
						}else{
							that.msg_0 = 4;
						}
					}
				});
				this.msg_0 = 2;
				return false;
			},
			checkPassword: function(){
				var password = this.password;
				var reg = /^\w{3,20}$/;
				if(!reg.test(password)){
					this.msg_1 = 1;
					return false;
				}
				this.msg_1 = 2;
				return true;
			},
			checkPassword2: function(){
				var password = this.password2;
				var reg = /^\w{3,20}$/;
				if(!reg.test(password)){
					this.msg_2 = 1;
					return false;
				}
				if(this.password != password){
					this.msg_2 = 2;
					return false;
				}
				this.msg_2 = 3;
				return true;
			},
			checkEmailCode: function(){
				var emailCode = this.emailCode;
				if(!!!emailCode){
					this.msg_3 = 3;
					return false;
				}
				return true;
			},
			getEmailCode: function(){
				var that = this;
				if(that.msg_0 != 4){
					return ;
				}
				var username = that.username;
				if(that.canSendEmailCode){
					$.ajax({
						url:"${APP_DIR}/user/getEmailCode?username="+username,
						type:"GET",
						success:function(msg){
							if(msg.code == <%=Msg.Code.SUCCESS%>){
								that.msg_3 = 2;
							}else{
								that.msg_3 = 1;
							}
						}
					});
					that.seconds = 60;
					that.timer = setInterval(function(){
						that.seconds--;
						if(that.seconds == 0){
							clearInterval(that.timer);
							that.canSendEmailCode = true;
							if(that.msg_3 == 2){
								that.msg_3 = '';
							}
						}
					},1000);
					that.canSendEmailCode = false;
				}
			},
			findBack: function(){
				if(this.msg_0 == 4 && this.checkPassword() && this.checkPassword2() && this.checkEmailCode()){
					var that = this;
					$.ajax({
						url:"${APP_DIR}/user/findBack",
						data:{
							username: that.username,
							password: md5(that.password),
							emailCode: that.emailCode,
						},
						type:"POST",
						success:function(msg){
							if(msg.code == <%=Msg.Code.SUCCESS%>){
								alert("找回成功");
								window.history.go(-1);
							}else{
								alert(msg.info);
							}
						}
					});
				}				
			}
		}
	});
</script>
</html>