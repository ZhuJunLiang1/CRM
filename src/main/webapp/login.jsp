<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<style type="text/css">

	</style>
	<script>
		$(function () {
			if(window.top != window){
				window.top.location=window.location;
			}

			//页面加载完毕后，用户文本框自动获得焦点
			$("#loginAct").focus();
			//用户文本框内容清空
			$("#loginAct").val("");
			$("#loginPwd").val("");
			$("#submitBtn").click(function () {
				login();
			})
			$("#regBtn").click(function () {
				register();
			})
			// $(window).keydown(function (event) {
			// 	//回车 登录
			// 	if(event.keyCode == 13){
			// 		login();
			// 	}
			// })
		})
		function getPic() {
			$("#checkCode").attr("src","settings/user/getCheckCode.do?flag="+Math.random());
		}
		function getRegPic() {
			$("#regCheckCode").attr("src","settings/user/getCheckCode.do?flag="+Math.random());
		}
		function changeRegForm() {
			$("#loginForm").css('display','none');
			$("#regForm").css('display','');
			$("#loginTitle").css('color','rgba(94,91,91,0.38)');
			$("#regTitle").css('color','black');
			$("#box").css('height','730px');
			getRegPic();
		}
		function changeLogForm() {
			$("#loginForm").css('display','');
			$("#regForm").css('display','none');
			$("#loginTitle").css('color','black');
			$("#regTitle").css('color','rgba(94,91,91,0.38)');
			$("#box").css('height','400px');
			getPic();
		}
		
		//普通自定义function方法写到
		//$.trim(XX) 去除 xx的前后空格
		function login() {
			var code = $.trim($("#code").val());
			var loginAct = $.trim($("#loginAct").val());
			var loginPwd = $.trim($("#loginPwd").val());
			if(loginAct == "" || loginPwd == ""){
				$("#msg").html("用户名密码不能为空");
				getPic()
				//若账密为空，则强制终止该方法
				return false;
			}
			if (code == ""){
                $("#msg").html("验证码不能为空");
				getPic()
                return false;
            }
			//后台验证登录相关操作（AJAX）
			$.ajax({
				url : "settings/user/login.do",
				data : {
					"loginAct" : loginAct,
					"loginPwd" : loginPwd,
                    "code" : code
				},
				type : "post",
				dataType : "json",
				success: function (data) {
					/*
					data{"success" : true/false,"msg":"哪错了"}
					 */
					if(data.success){
						window.location.href="workbench/index.jsp";
					}else {
						$("#msg").html(data.msg);
						getPic()
					}
				}
			})
		}
		function register() {
			var loginAct = $.trim($("#regAct").val());
			var password = $("#regPwd").val();
			var checkRegPwd = $("#checkRegPwd").val();
			var email = $.trim($("#email").val());
			var dept = $("#dept").val();
			var code = $.trim($("#regCode").val());
			var allowIp = $.trim($("#allowIp").val());
			var name = $.trim($("#name").val());

			if (loginAct == "" || password == ""){
				$("#regMsg").html("用户名密码不能为空");
				getRegPic()
				return false;
			}
			if (name == ""){
				$("#regMsg").html("姓名不能为空");
				getRegPic()
				return false;
			}
			if (password != checkRegPwd){
				$("#regMsg").html("密码与确认密码不一致");
				getRegPic()
				return false;
			}
			if (email == ""){
				$("#regMsg").html("邮箱不能为空");
				getRegPic()
				return false;
			}
			if (email.indexOf("@",0) == -1 || email.indexOf(".",0) == -1){
				$("#regMsg").html("邮箱地址不正确 必须有@和.符号");
				getRegPic()
				return false;
			}
			if (allowIp == ""){
				$("#regMsg").html("登录IP至少要有一个");
				getRegPic()
				return false;
			}
			if (code == ""){
				$("#regMsg").html("验证码不能为空");
				getRegPic()
				return false;
			}
			$.ajax({
				url: "settings/user/register.do",
				data: {
					"loginAct" : loginAct,
					"loginPwd" : password,
					"name" : name,
					"email" : email,
					"dept" : dept,
					"allowIps" : allowIp,
					"code" : code
				},
				type: "post",
				dataType: "json",
				success : function (data) {
					if(data.success){
						alert("注册成功，点击确定跳转到登录页！")
						window.location.href="login.jsp";
					}else {
						$("#regMsg").html(data.msg);
						getRegPic()
					}
				}
			})
		}
	</script>

</head>
<body>
	<div style="position: absolute; top: 0px; left: 150px; width: 60%;">
		<img src="image/IMG_index.JPG" style="width: 80%; height: 70%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;</div>
	</div>
	
	<div id="box" style="position: absolute; top: 120px; right: 150px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1 id="loginTitle" onclick="changeLogForm()" style="display: inline-block;float: left">登录</h1>
				<h1 id="regTitle" onclick="changeRegForm()" style="display: inline-block;float: right;color: gray">注册</h1>
			</div>

				<form action="workbench/index.jsp" id="loginForm" class="form-horizontal" role="form">
					<div class="form-group form-group-lg">
						<div style="width: 350px;">
							<input class="form-control" type="text" placeholder="用户名" id="loginAct">
						</div>
						<div style="width: 350px; position: relative;top: 20px;">
							<input class="form-control" type="password" placeholder="密码" id="loginPwd">
						</div>
						<div style="width: 350px; height: 46px; position: relative;top: 40px;">
							<input class="form-control" type="text" placeholder="验证码" id="code" style="float: left;width: 60%">
							<img src="settings/user/getCheckCode.do" id="checkCode" title="点击切换验证码" style="display: inline-block;width: 35%;float: right" onclick="getPic()"/>

						</div>
						<div style="width: 350px; position: relative;top: 60px; left: 10px;">
								<span id="msg" style="color: red"></span>
						</div>

						<button type="button" id="submitBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 70px;">登录</button>
					</div>
				</form>

			<form action="workbench/index.jsp" id="regForm" style="display: none" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="用户名" id="regAct">
					</div>
					<div style="width: 350px;position: relative;top: 20px;">
						<input class="form-control" type="text" placeholder="姓名" id="name">
					</div>
					<div style="width: 350px; position: relative;top: 40px;">
						<input class="form-control" type="password" placeholder="密码" id="regPwd">
					</div>
					<div style="width: 350px; position: relative;top: 60px;">
						<input class="form-control" type="password" placeholder="确认密码" id="checkRegPwd">
					</div>
					<div style="width: 350px; position: relative;top: 80px;">
						<input class="form-control" type="email" placeholder="邮箱" id="email">
					</div>
					<div style="width: 350px; position: relative;top: 100px;">
						<input class="form-control" type="text" placeholder="部门" id="dept">
					</div>
					<div style="width: 350px; position: relative;top: 120px;">
						<input class="form-control" type="text" placeholder="IP地址（多个用逗号隔开）" id="allowIp">
					</div>
					<div style="width: 350px;height: 46px; position: relative;top: 140px;">
						<input class="form-control" type="text" placeholder="验证码" id="regCode" style="float: left;width: 60%">
						<img src="settings/user/getCheckCode.do" id="regCheckCode" title="点击切换验证码" style="display: inline-block;width: 35%;float: right" onclick="getRegPic()"/>

					</div>
					<div style="width: 350px; position: relative;top: 160px; left: 10px;">
						<span id="regMsg" style="color: red"></span>
					</div>

					<button type="button" id="regBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 170px;">注册</button>
				</div>
			</form>

		</div>
	</div>
</body>
</html>