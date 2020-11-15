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
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

	<script type="text/javascript">
		$(function () {
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom"
			})
			//点击添加按钮
			$("#addBtn").click(function () {
				$.ajax({
					url:"settings/user/getDept.do",
					type:"get",
					dataType:"json",
					success:function (data) {
						var html = "<option></option>";
						$.each(data,function (i,n) {
							html += "<option value='"+n.no+ "'>" + n.name + "</option>";
						})
						$("#create-dept").html(html);
						$("#createUserModal").modal("show");
					}
				})
			})
			//保存按钮
			$("#saveBtn").click(function () {
				var loginPwd = $("#create-loginPwd").val();
				var confirmPwd = $("#create-confirmPwd").val();
				if(loginPwd == "" || confirmPwd == ""){
					alert("请输入密码");
					return false;
				}
				if(loginPwd != confirmPwd){
					alert("密码与确认密码不一致！");
					return false;
				}
				$.ajax({
					url:"settings/user/save.do",
					data:{
						"loginAct": $.trim($("#create-loginAct").val()),
						"name": $.trim($("#create-username").val()),
						"loginPwd": $.trim($("#create-loginPwd").val()),
						"email": $.trim($("#create-email").val()),
						"expireTime": $.trim($("#create-expireTime").val()),
						"lockState": $.trim($("#create-lockState").val()),
						"deptno": $.trim($("#create-dept").val()),
						"allowIps": $.trim($("#create-allowIps").val()),
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						if(data.success){
							pageList(1,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
							$("#userAddForm")[0].reset();
							$("#createUserModal").modal("hide")
						}else {
							alert("添加用户失败！");
						}
					}
				})
			})

			//为全选复选框绑定事件，触发全选操作
			$("#checkAll").click(function () {
				$("input[name=check]").prop("checked",this.checked);
			})
			//动态生成的元素以 on 方法触发事件
			//语法：$(需要绑定的元素的有效的外层元素).on(事件，jquery对象，函数)
			$("#userBody").on("click",$("input[name=check]"),function () {
				$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
			})

			pageList(1,10);

			//为查询按钮绑定事件，触发pageList方法
			$("#searchBtn").click(function () {
				//点击查询按钮的时候，将搜索框中信息使用隐藏域保存
				$("#hidden-name").val($.trim($("#search-name ").val()));
				$("#hidden-dept").val($.trim($("#search-dept").val()));
				$("#hidden-lockState").val($.trim($("#search-lockState").val()));
				$("#hidden-startDate").val($.trim($("#search-startDate").val()));
				$("#hidden-endDate").val($.trim($("#search-endDate").val()));
				//回到第一页，维持当前每页数据
				pageList(1,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
			});

			//删除按钮绑定事件，执行用户的删除操作
			$("#deleteBtn").click(function () {
				//找到复选框中所有选中的的jquery
				var $check = $("input[name=check]:checked");
				if($check.length == 0){
					alert("请选择需要删除的记录");
				}else {
					if(confirm("确定删除所选中的记录吗?")){
						//拼接参数
						var param = "";
						for(var i=0;i<$check.length;i++){
							param += "id="+$check[i].value;
							//如果不是最后一条元素需要追加一个&
							if (i<$check.length-1){
								param += "&";
							}
						}
						$.ajax({
							url:"settings/user/delete.do",
							data:param,
							type:"post",
							dataType:"json",
							success:function (data) {
								if(data.success){
									//回到第一页，维持 每页展现记录数
									pageList(1,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
								}else {
									alert("删除用户失败");
								}
							}
						})
					}
				}
			})

		})
		//局部刷新获取用户列表
		function pageList(pageNo,pageSize) {
			//去掉checkAll勾选状态
			$("#checkAll").prop("check",false);
			//查询前将隐藏域中保存信息取出来，重新赋予到搜索框中
			$("#search-name").val($.trim($("#hidden-name ").val()));
			$("#search-dept").val($.trim($("#hidden-dept").val()));
			$("#search-lockState").val($.trim($("#hidden-lockState").val()));
			$("#search-startDate").val($.trim($("#hidden-startDate").val()));
			$("#search-endDate").val($.trim($("#hidden-endDate").val()));
			$.ajax({
				url:"settings/user/pageList.do",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"name":$.trim($("#search-name").val()),
					"deptno":$.trim($("#search-dept").val()),
					"lockState":$.trim($("#search-lockState").val()),
					"startDate":$.trim($("#search-startDate").val()),
					"endDate":$.trim($("#search-endDate").val()),
				},
				type:"get",
				dataType:"json",
				success:function (data) {
					var html = "";
					$.each(data.dataList,function (i,n) {
						var lockState = n.lockState == 1 ? "启用" : "锁定";
						html += '<tr class="active">'
						html += '<td><input name="check" type="checkbox" value="'+n.id+'" /></td>'
						html += '<td>'+(i+1)+'</td>'
						html += '<td><a  onclick="window.location.href=\'settings/user/detail.do?id='+n.id+'\';">'+n.loginAct+'</a></td>'
						html += '<td>'+n.name+'</td>'
						html += '<td>'+n.deptno+'</td>'
						html += '<td>'+n.email+'</td>'
						html += '<td>'+n.expireTime+'</td>'
						html += '<td>'+n.allowIps+'</td>'
						html += '<td>'+lockState+'</td>'
						html += '<td>'+n.createBy+'</td>'
						html += '<td>'+n.createTime+'</td>'
						html += '<td>'+n.editBy+'</td>'
						html += '<td>'+n.editTime+'</td>'
						html += '</tr>'
					})
					$("#userBody").html(html);
					//计算总页数
					var totalPages = data.total%pageSize == 0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;
					//数据处理完毕后，结合分页插件
					$("#userPage").bs_pagination({
						currentPage: pageNo, // 页码
						rowsPerPage: pageSize, // 每页显示的记录条数
						maxRowsPerPage: 20, // 每页最多显示的记录条数
						totalPages: totalPages, // 总页数
						totalRows: data.total, // 总记录条数

						visiblePageLinks: 3, // 显示几个卡片

						showGoToPage: true,
						showRowsPerPage: true,
						showRowsInfo: true,
						showRowsDefaultInfo: true,

						//该回调函数在点击分页组件的时候触发
						onChangePage : function(event, data){
							pageList(data.currentPage , data.rowsPerPage);
						}
					});
				}
			});
		}
	</script>
</head>
<body>
<input type="hidden" id="hidden-name">
<input type="hidden" id="hidden-dept">
<input type="hidden" id="hidden-lockState">
<input type="hidden" id="hidden-startDate">
<input type="hidden" id="hidden-endDate">
	<!-- 创建用户的模态窗口 -->
	<div class="modal fade" id="createUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="userAddForm" role="form">
					
						<div class="form-group">
							<label for="create-loginAct" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-loginAct">
							</div>
							<label for="create-username" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-username">
							</div>
						</div>
						<div class="form-group">
							<label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-loginPwd">
							</div>
							<label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="create-lockState" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-lockState">
								  <option></option>
								  <option value="1">启用</option>
								  <option value="0">锁定</option>
								</select>
							</div>
							<label for="create-dept" class="col-sm-2 control-label">部门<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="create-dept">
                                </select>
                            </div>
						</div>
						<div class="form-group">
							<label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-allowIps" style="width: 280%" placeholder="多个用逗号隔开">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户列表</h3>
			</div>
		</div>
	</div>
	
	<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
		<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">用户姓名</div>
		      <input class="form-control" type="text" id="search-name">
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">部门名称</div>
		      <input class="form-control" type="text" id="search-dept">
		    </div>
		  </div>
		  &nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">锁定状态</div>
			  <select class="form-control" id="search-lockState">
			  	  <option></option>
			      <option value="0">锁定</option>
				  <option value="1">启用</option>
			  </select>
		    </div>
		  </div>
		  <br><br>
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">失效时间</div>
			  <input class="form-control time" type="text" id="search-startDate" />
		    </div>
		  </div>
		  
		  ~
		  
		  <div class="form-group">
		    <div class="input-group">
			  <input class="form-control time" type="text" id="search-endDate" />
		    </div>
		  </div>
		  
		  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
		  
		</form>
	</div>
	
	
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
		
	</div>
	
	<div style="position: relative; left: 30px; top: 40px; width: 110%">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="checkAll" type="checkbox" /></td>
					<td>序号</td>
					<td>登录帐号</td>
					<td>用户姓名</td>
					<td>部门名称</td>
					<td>邮箱</td>
					<td>失效时间</td>
					<td>允许访问IP</td>
					<td>锁定状态</td>
					<td>创建者</td>
					<td>创建时间</td>
					<td>修改者</td>
					<td>修改时间</td>
				</tr>
			</thead>
			<tbody id="userBody">
			</tbody>
		</table>
	</div>
	
	<div style="height: 50px; position: relative;top: 30px; left: 30px;">
		<div id="userPage">
		</div>
	</div>
</body>
</html>