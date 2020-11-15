<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<base href="<%=basePath%>">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<SCRIPT type="text/javascript">
	$(function () {
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom"
		})
		$("#create-dept").typeahead({
			source: function (query, process) {
				$.get(
						"settings/user/getDeptName.do",
						{ "name" : query },
						function (data) {
							process(data);
						},
						"json"
				);
			},
			delay: 1500
		});
		$("#updateBtn").click(function () {
			var loginPwd = $("#edit-loginPwd").val();
			var confirmPwd = $("#edit-confirmPwd").val();
			if(loginPwd == "" || confirmPwd == ""){
				alert("请输入密码");
				return false;
			}
			if(loginPwd != confirmPwd){
				alert("密码与确认密码不一致！");
				return false;
			}
			$.ajax({
				url:"settings/user/update.do",
				data:{
					"id": $.trim($("#userId").val()),
					"loginAct":$.trim($("#edit-loginAct").val()),
					"name":$.trim($("#edit-name").val()),
					"loginPwd":$.trim($("#edit-loginPwd").val()),
					"email":$.trim($("#edit-email").val()),
					"expireTime":$.trim($("#edit-expireTime").val()),
					"lockState":$.trim($("#edit-lockState").val()),
					"dept":$.trim($("#edit-dept").val()),
					"allowIps":$.trim($("#edit-allowIps").val()),
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					if(data.success){
						$.ajax({
							url:"settings/user/getDetailById.do",
							data:{
								"id":"${user.id}"
							},
							type:"get",
							dataType:"json",
							success:function (data1) {
								$("#user-loginAct").html(data1.loginAct);
								$("#user-name").html(data1.name);
								$("#user-email").html(data1.email);
								$("#user-expireTime").html(data1.expireTime);
								$("#user-allowIps").html(data1.allowIps);
								$("#user-deptno").html(data1.deptno);
								$("#user-lockState").html((data1.lockState==1)? "启用" : "锁定");
							}
						})
						$("#editUserForm")[0].reset();
						$("#editUserModal").modal("hide");
					}else {
						alert("修改用户失败！");
					}
				}
			})
		})
	})
	
</SCRIPT>

</head>
<body>
	<!-- 编辑用户的模态窗口 -->
	<div class="modal fade" id="editUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="editUserForm" role="form">
					
						<div class="form-group">
							<label for="edit-loginAct" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-loginAct" value="${user.loginAct}">
							</div>
							<label for="edit-name" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" value="${user.name}">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="edit-loginPwd" value="${user.loginPwd}">
							</div>
							<label for="edit-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="edit-confirmPwd" value="${user.loginPwd}">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="${user.email}">
							</div>
							<label for="edit-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-expireTime" value="${user.expireTime}">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-lockState" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-lockState">
								  <option></option>
								  <option ${user.lockState eq 1 ? 'selected':'' } value="1">启用</option>
								  <option ${user.lockState eq 0 ? 'selected':'' } value="0">锁定</option>
								</select>
							</div>
							<label for="edit-dept" class="col-sm-2 control-label">部门名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-dept" placeholder="输入部门名称，自动补全" value="${user.deptno}">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-allowIps" style="width: 280%" placeholder="多个用逗号隔开" value="${user.allowIps}">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户明细 <small>${user.name}&nbsp;</small></h3>
			</div>
			<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 80%;">
				<button type="button" class="btn btn-default" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"></span> 返回</button>
			</div>
		</div>
	</div>
	
	<div style="position: relative; left: 60px; top: -50px;">
		<input id="userId" type="hidden" value="${user.id}">
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="role-info">
				<div style="position: relative; top: 20px; left: -30px;">
					<div style="position: relative; left: 40px; height: 30px; top: 20px;">
						<div style="width: 300px; color: gray;">登录帐号</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-loginAct">${user.loginAct}&nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 40px;">
						<div style="width: 300px; color: gray;">用户姓名</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-name">${user.name}&nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 60px;">
						<div style="width: 300px; color: gray;">邮箱</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-email">${user.email}&nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 80px;">
						<div style="width: 300px; color: gray;">失效时间</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-expireTime">${user.expireTime}&nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 100px;">
						<div style="width: 300px; color: gray;">允许访问IP</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-allowIps">${user.allowIps}&nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 120px;">
						<div style="width: 300px; color: gray;">锁定状态</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-lockState">${user.lockState eq 1 ?'启用':'锁定'} &nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 140px;">
						<div style="width: 300px; color: gray;">部门名称</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="user-deptno">${user.deptno}&nbsp;</b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
						<button style="position: relative; left: 76%; top: -40px;" type="button" class="btn btn-default" data-toggle="modal" data-target="#editUserModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
</body>
</html>