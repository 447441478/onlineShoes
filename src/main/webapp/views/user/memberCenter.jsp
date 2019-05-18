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
#memberCenter{
	background: #f5f5f5;
}
.menu{
	text-align: center;
	height: 400px;
	box-sizing: border-box;
	padding: 0;
	border-right: 1px solid #eee;
}
.menu .item{
	color: #666666;
	height: 32px;
	line-height:32px;
	font-size: 14px;
	cursor: pointer;
}
.menu .item.active{
	color: #e4393c;
	border-left: 5px solid #e4393c;  
}
.line{
    height: 30px;
    line-height: 30px;
    margin-bottom: 16px;
}
.leftSpan{
	height: 35px;
    line-height: 35px;
    text-align: right;
    font-size: 14px;
    font-family: "微软雅黑";
    float: left;
    width: 26%;
}
.rightSpan{
    width: 65%;
    text-align: left;
    padding: 0;
    float: left;
    padding-left: 8px;
}
.rightSpan input{
	border: 1px solid #e9e9e9;
	outline-color: #dedede;
    line-height: 35px;
    height: 35px;
    width: 200px;
    padding: 0 5px;
    font-family: 微软雅黑;
    color: #8c8c8c;
    border-color: #dadada;
    border-radius: 3px;
    font-size: 12px;
}
.saveBtn{
    width: 110px;
    height: 37px;
    line-height: 37px;
    border-radius: 3px;
    font-size: 14px;
    font-family: "微软雅黑";
    color: #fff;
    text-align: center;
    cursor: pointer;
    background: #e4393c;
    margin: 0 auto;
    float: left;
 }
</style>
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">会员中心</div>
	</div>
	<div class="container-fluid" id="memberCenter">
		<div class="row" style="padding: 16px;background-color: #fff;">
			<div class="col-xs-3 menu">
				<div class="item" v-for='item in menus' @click='switchMenu(item)' :class='getExtClass(item)'>{{item.name}}</div>
			</div>
			<div class="col-xs-8" v-if='activeItemKey == 0'>
				<div class="line">
					<span class="leftSpan" >用户名：</span>
					<span class="rightSpan">
						<input value="${user.username}" disabled="disabled"/>
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">邮箱：</span>
					<span class="rightSpan">
						<input v-model='email' placeholder="请输入电子邮箱" />
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">会员：</span>
					<span class="rightSpan">
						<input value="普通会员" disabled="disabled"/>
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">登录密码：</span>
					<span class="rightSpan">
						<span v-if='!showPwd' style='cursor: pointer;' @click='showPwd = !showPwd'>[修改]</span>
						<span v-else style='cursor: pointer;' @click='showPwd = !showPwd'>[取消修改]</span>
					</span>
				</div>
			<template v-if='showPwd'>
				<div class="line">
					<span class="leftSpan">旧密码：</span>
					<span class="rightSpan">
						<input type="password" v-model='oldPwd' placeholder="3-20个字符，区分大小写"/>
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">新密码：</span>
					<span class="rightSpan">
						<input type="password" v-model='newPwd' placeholder="3-20个字符，区分大小写"/>
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">确认新密码：</span>
					<span class="rightSpan">
						<input type="password" v-model='newPwd2' placeholder="3-20个字符，区分大小写"/>
					</span>
				</div>
			</template>
				<div class="line">
					<span class="leftSpan"></span>
					<span class="rightSpan">
						<span class='saveBtn' @click='save0()'>保 存</span>
					</span>
				</div>
			</div>
			<div class="col-xs-8" v-if='activeItemKey == 1'>
				<div class="line">
					<span class="leftSpan">姓名：</span>
					<span class="rightSpan">
						<input v-model='name' placeholder="" />
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">电话：</span>
					<span class="rightSpan">
						<input v-model='tel' placeholder="" />
					</span>
				</div>
				<div class="line">
					<span class="leftSpan">地址：</span>
					<span class="rightSpan">
						<input v-model='addr' placeholder="" />
					</span>
				</div>
				<div class="line">
					<span class="leftSpan"></span>
					<span class="rightSpan">
						<span class='saveBtn' @click='save1()'>保 存</span>
					</span>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var menus = [
	{
		key:0,
		name:"我的资料"
	},
	{
		key:1,
		name:"收货人信息"
	},
];

var address = ${address};

var v_memberCenter = new Vue({
	el: "#memberCenter",
	data: function(){
		return {
			activeItemKey: 0,
			menus: menus,
			showPwd: false,
			email:'${user.email}',
			oldPwd:'',
			newPwd:'',
			newPwd2:'',
			name: address.name,
			tel: address.tel,
			addr: address.address,
		}
	},
	methods: {
		getExtClass: function(item){
			if(item.key == this.activeItemKey){
				return "active";
			}
		},
		switchMenu: function(item){
			this.activeItemKey = item.key;
		},
		save0: function(){
			var email = this.email;
			var data = {};
			if(!this.checkEmail(email)){
				alert("邮箱格式不正确");
				return ;
			}
			data.email = email;
			if(this.showPwd){
				var oldPwd = this.oldPwd;
				if(!this.checkPassword(oldPwd)){
					alert("旧密码格式不正确");
					return ;
				}
				var newPwd = this.newPwd;
				if(!this.checkPassword(newPwd)){
					alert("新密码格式不正确");
					return ;
				}
				var newPwd2 = this.newPwd2;
				if(!this.checkPassword(newPwd2)){
					alert("确认新密码格式不正确");
					return ;
				}
				if(newPwd != newPwd2){
					alert("新密码和确认新密码不一致");
					return ;
				}
				data.oldPwd = md5(oldPwd);
				data.newPwd = md5(newPwd);
			}
			$.ajax({
				url:"${APP_DIR}/user/updateMember",
				data:data,
				type:"POST",
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						alert("保存成功。");
						location.reload();
					}else{
						alert(msg.info);
					}
				}
			});
			
		},
		checkPassword: function(password){
			var reg = /^\w{3,20}$/;
			if(!reg.test(password)){
				return false;
			}
			return true;
		},
		checkEmail: function(email){
			var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
			if(!reg.test(email)){
				return false;
			}
			return true;
		},
		save1: function(){
			var name = this.name;
			if(!name){
				alert("姓名不能为空。");
				return ;
			}
			if(name.length > 30){
				alert("姓名不能超过30个字符。");
				return ;
			}
			var tel = this.tel;
			if(!tel){
				alert("手机不能为空。");
				return ;
			}
			var reg = /^[1][3,4,5,7,8][0-9]{9}$/;
			if(!reg.test(tel)){
				alert("请输入正确的手机号码。");
			}
			var addr = this.addr;
			if(!addr){
				alert("地址不能为空。");
				return ;
			}
			if(addr.length > 20){
				alert("地址不能超过20个字符。");
				return ;
			}
			$.ajax({
				url:"${APP_DIR}/user/addAddr",
				data: {
					name: name,
					tel: tel,
					address: addr,
				},
				type:"POST",
				success:function(msg){
					if(msg.code == <%=Msg.Code.SUCCESS%>){
						alert("保存成功。");
						location.reload();
					}else{
						alert(msg.info);
					}
				}
			});
		}
	}
});
</script>
</html>