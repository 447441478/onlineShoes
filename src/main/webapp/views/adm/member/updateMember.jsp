<%@page import="net.hncu.onlineShoes.domain.User"%>
<%@page import="net.hncu.onlineShoes.domain.OrderDetail"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.hncu.onlineShoes.util.Msg"%>
<%@page import="net.hncu.onlineShoes.comm.*"%>
<%@page import="net.hncu.onlineShoes.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>管理产品</title>
<%@ include file="/inc/admCommon_js_css.jsp.inc" %>
<!-- 引入Bootstrap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<style type="text/css">
.member .item{
    margin-bottom: 20px;
}
.member .item .title{
    font-size: 13px;
    color: #333;
    display: inline-block;
    vertical-align: middle;
    margin-right: 15px;
}
.member .item .tip{
    font-size: 12px;
    color: #c9302c;
    display: inline-block;
    vertical-align: middle;
    margin-left: 13px;
}
.authority{
    display: inline-block;
    border: 1px solid #e3e3e3;
    border-radius: 10px;
	padding: 0 6px 0 15px;
    margin-right: 6px;
}
.authority:hover .close{
	color: #000;
}
.authority .close{
	color: #fff;
}
.authority .notColse{
    width: 3px;
    display: inline-block;
    margin: 0;
    padding: 0;
}
.add{
	color: #888;
	cursor: pointer;
}
.add:hover{
	color: #000;
}
</style>

</head>
<script type="text/javascript">
	
</script>
<body  style="overflow-x: hidden; overflow-y: auto;">
	<div class="top_bar">
		<div class="top_bar_title">修改订单</div>
	</div>
	<div id="member">
	<div class="member"  style="padding-top: 35px; padding-left: 35px;">
		<div class="item">
			<span class="title">账号：</span>
			<input v-model="member.username" disabled="disabled"/>
		</div>
		<div class="item">
			<span class="title">邮箱：</span>
			<input v-model="member.email"/>
			<span class='tip'>{{emailTip}}</span>
		</div>
		<div class="item">
			<span class="title">权限：</span>
			<div class='authority' v-for='item in authoritys' >
				<span :title='item.text'>{{item.text}}</span>
				<i v-if='item.flag != <%=User.Flag.FREE%>' class="close" title='删除' @click.stop="closeFlag(item.flag)">&times;</i>
				<i v-else class='notColse'></i>
			</div>
			<span v-if='canAdd' class="glyphicon glyphicon-plus add" @click="showSelect = true"></span>
			<select class="form-control" style="width: 120px;display: inline-block;" v-if='showSelect' @change="changeFlag($event)" @blur='showSelect=false;'>
				<option v-for='item in options' :value="item.flag">{{item.text}}</option>
			</select>
		</div>
	</div>
	<div style="text-align: center; margin-top: 50px;">
		<button type="button" class="btn btn-primary btn-sm" :disabled='!canSave' style="margin-right: 28px;" @click="save()">确 定</button>
		<button type="button" class="btn btn-danger btn-sm" @click="cancel()">取 消</button>
	</div>
	</div>
</body>

<script type="text/javascript">
	var member = ${member};
	var vm_member = new Vue({
		el:"#member",
		data:function(){
			return{
				member: member,
				emailTip:null,
				showSelect: false,
				oldFlag: member.flag,
			}
		},
		computed:{
			canAdd: function(){
				return !this.showSelect && this.options.length != 1;
			},
			canSave:function(){
				if(this.emailTip == null && this.member.flag == this.oldFlag){
					return false;
				}
				if(!this.emailTip || this.member.flag != this.oldFlag){
					return true;
				}else{
					return false;
				}
			},
			authoritys: function(){
				var arr = [];
				var flag = this.member.flag;
				if((flag & <%=User.Flag.FREEZE%>) == <%=User.Flag.FREEZE%>){
					arr.push({flag: <%=User.Flag.FREEZE%>,text:"已被冻结"});
					return arr;
				}
				if((flag & <%=User.Flag.SUPER_MANAGER%>) == <%=User.Flag.SUPER_MANAGER%>){
					arr.push({flag: <%=User.Flag.SUPER_MANAGER%>,text:"超级管理员"});
					return arr;
				}
				if((flag & <%=User.Flag.PRODUCT_MANAGER%>) == <%=User.Flag.PRODUCT_MANAGER%>){
					arr.push({flag: <%=User.Flag.PRODUCT_MANAGER%>,text:"产品管理员"});
				}
				if((flag & <%=User.Flag.ORDER_MANAGER%>) == <%=User.Flag.ORDER_MANAGER%>){
					arr.push({flag: <%=User.Flag.ORDER_MANAGER%>,text:"订单管理员"});
				}
				if((flag & <%=User.Flag.MEMBER_MANAGER%>) == <%=User.Flag.MEMBER_MANAGER%>){
					arr.push({flag: <%=User.Flag.MEMBER_MANAGER%>,text:"会员管理员"});
				}
				if((flag & <%=User.Flag.VIP%>) == <%=User.Flag.VIP%>){
					arr.push({flag: <%=User.Flag.VIP%>,text:"超级会员"});
					return arr;
				}
				if(arr.length != 0){
					return arr;
				}
				if(flag == <%=User.Flag.FREE%>){
					arr.push({flag: <%=User.Flag.FREE%>,text:"普通会员"});
					return arr;
				}
			},
			options: function(){
				var arr = [];
				var flag = this.member.flag;
				arr.push({flag: -1,text:'--请选择--'});
				if((flag & <%=User.Flag.VIP%>) != <%=User.Flag.VIP%>){
					arr.push({flag: <%=User.Flag.VIP%>,text:"超级会员"});
				}
				if((flag & <%=User.Flag.PRODUCT_MANAGER%>) != <%=User.Flag.PRODUCT_MANAGER%>){
					arr.push({flag: <%=User.Flag.PRODUCT_MANAGER%>,text:"产品管理员"});
				}
				if((flag & <%=User.Flag.ORDER_MANAGER%>) != <%=User.Flag.ORDER_MANAGER%>){
					arr.push({flag: <%=User.Flag.ORDER_MANAGER%>,text:"订单管理员"});
				}
				if((flag & <%=User.Flag.MEMBER_MANAGER%>) != <%=User.Flag.MEMBER_MANAGER%>){
					arr.push({flag: <%=User.Flag.MEMBER_MANAGER%>,text:"会员管理员"});
				}
				if((flag & <%=User.Flag.FREEZE%>) != <%=User.Flag.FREEZE%>){
					arr.push({flag: <%=User.Flag.FREEZE%>,text:"已被冻结"});
				}
				return arr;
			}
		},
		watch:{
			'member.email':function(val){
				if(!val){
					this.emailTip = '邮箱不能为空';
					return;
				}
				var reg =/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
				if(!reg.test(String(val))){
					this.emailTip = '邮箱格式不正确';
					return false;
				}
				if(val.length > 50){
					this.emailTip = '邮箱不能超过30个字符';
					return;
				}
				this.emailTip = '';
			},
		},
		methods:{
			changeFlag: function(e){
				var flag = Number($(e.target).val()) || 0;
				this.showSelect = false;
				this.member.flag |= flag;
			},
			closeFlag: function(flag){
				/*if(flag == <%=User.Flag.FREE%>){
					this.member.flag |= <%=User.Flag.FREEZE%>;
					return ;
				}*/
				this.member.flag &= ~flag;
			},
			getAuthority: function(){
				var flag = this.member.flag;
				if((flag & <%=User.Flag.FREEZE%>) == <%=User.Flag.FREEZE%>){
					return "已被冻结";
				}
				if((flag & <%=User.Flag.SUPER_MANAGER%>) == <%=User.Flag.SUPER_MANAGER%>){
					return "超级管理员";
				}
				var str = "";
				if((flag & <%=User.Flag.PRODUCT_MANAGER%>) == <%=User.Flag.PRODUCT_MANAGER%>){
					str += "产品管理员，";
				}
				if((flag & <%=User.Flag.ORDER_MANAGER%>) == <%=User.Flag.ORDER_MANAGER%>){
					str += "订单管理员，";
				}
				if((flag & <%=User.Flag.MEMBER_MANAGER%>) == <%=User.Flag.MEMBER_MANAGER%>){
					str += "会员管理员，";
				}
				if(str != ""){
					return str.substring(0,str.length-1);
				}
				if((flag & <%=User.Flag.VIP%>) == <%=User.Flag.VIP%>){
					return "超级会员";
				}
				if(flag == <%=User.Flag.FREE%>){
					return "普通会员";
				}
			},
			cancel: function(){
				$(window.parent.document).find("#myModal").click();
			},
			save: function(){
				if(!confirm("确定修改？")){
					return ;
				}
				var data={
					userId: this.member.userId,
					email: this.member.email,
					flag: this.member.flag,
				};
				$.ajax({
					url: "${APP_DIR}/adm/member/update",
					type: "POST",
					data: data,
					success: function(){
						window.parent.location.reload();
					},
					error: function(){
						$(window.parent.document).find("#myModal").click();
					}
				});
			},
		},
	});
</script>
</html>