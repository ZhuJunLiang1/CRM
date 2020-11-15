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

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
	<script type="text/javascript">
		$(function () {

			//添加部门
			$("#saveBtn").click(function () {
				$.ajax({
					url:"settings/dept/save.do",
					data:{
						"no" : $.trim($("#create-no").val()),
						"name" : $.trim($("#create-name").val()),
						"manager" : $.trim($("#create-manager").val()),
						"phone" : $.trim($("#create-phone").val()),
						"description" : $.trim($("#create-description").val())
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						if(data.success){
							pageList(1,$("#deptPage").bs_pagination('getOption', 'rowsPerPage'));
							$("#deptAddForm")[0].reset();
							$("#createDeptModal").modal("hide")
						}else {
							alert("添加部门失败！");
						}
					}
				})
			});

			//为全选复选框绑定事件，触发全选操作
			$("#checkAll").click(function () {
				$("input[name=check]").prop("checked",this.checked);
			})

			//动态生成的元素以 on 方法触发事件
			//语法：$(需要绑定的元素的有效的外层元素).on(事件，jquery对象，函数)
			$("#deptBody").on("click",$("input[name=check]"),function () {
				$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
			})

			$("#editBtn").click(function () {
				var $check = $("input[name=check]:checked");
				if($check.length == 0){
					alert("请选择需要删除的记录");
				}else if ($check.length != 1){
					alert("请选择一条记录进行编辑");
				}else {
					$.ajax({
						url:"settings/dept/getDetailByNo.do",
						data:{
							no:$check.val()
						},
						type:"get",
						dataType:"json",
						success:function (data) {
							$("#edit-no").val(data.no);
							$("#edit-name").val(data.name);
							$("#edit-manager").val(data.manager);
							$("#edit-phone").val(data.phone);
							$("#edit-description").val(data.description);
							$("#editDeptModal").modal("show");
						}
					})
				}
			});

			$("#updateBtn").click(function () {
				$.ajax({
					url:"settings/dept/update.do",
					data:{
						"no" : $.trim($("#edit-no").val()),
						"name" : $.trim($("#edit-name").val()),
						"manager" : $.trim($("#edit-manager").val()),
						"phone" : $.trim($("#edit-phone").val()),
						"description" : $.trim($("#edit-description").val()),
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						if(data.success){
							pageList(1,$("#deptPage").bs_pagination('getOption', 'rowsPerPage'));
							$("#editDeptModal").modal("hide")
						}else {
							alert("更改部门信息失败！");
						}
					}
				})
			})

			pageList(1,10);

			//删除按钮绑定事件，执行部门的删除操作
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
							param += "no="+$check[i].value;
							//如果不是最后一条元素需要追加一个&
							if (i<$check.length-1){
								param += "&";
							}
						}
						$.ajax({
							url:"settings/dept/delete.do",
							data:param,
							type:"post",
							dataType:"json",
							success:function (data) {
								if(data.success){
									//回到第一页，维持 每页展现记录数
									pageList(1,$("#deptPage").bs_pagination('getOption', 'rowsPerPage'));
								}else {
									alert("删除部门失败");
								}
							}
						})
					}
				}
			})

		});
		//局部刷新获取用户列表
		function pageList(pageNo,pageSize) {
			//去掉checkAll勾选状态
			$("#checkAll").prop("check",false);
			$.ajax({
				url:"settings/dept/pageList.do",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
				},
				type:"get",
				dataType:"json",
				success:function (data) {
					var html = "";
					$.each(data.dataList,function (i,n) {
						html += '<tr class="active">'
						html += '<td><input name="check" type="checkbox" value="'+n.no+'" /></td>'
						html += '<td>'+n.no+'</td>'
						html += '<td>'+n.name+'</td>'
						html += '<td>'+n.manager+'</td>'
						html += '<td>'+n.phone+'</td>'
						html += '<td>'+n.description+'</td>'
						html += '</tr>'
					})
					$("#deptBody").html(html);
					//计算总页数
					var totalPages = data.total%pageSize == 0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;
					//数据处理完毕后，结合分页插件
					$("#deptPage").bs_pagination({
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
	<!-- 创建部门的模态窗口 -->
	<div class="modal fade" id="createDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" ><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="deptAddForm" role="form">
					
						<div class="form-group">
							<label for="create-no" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-no" style="width: 200%;" placeholder="编号不能为空，具有唯一性">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-manager" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn" >保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="editDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" ><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-no" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" readonly id="edit-no" style="width: 200%;" placeholder="不能为空，具有唯一性" value="${dept.no}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" style="width: 200%;" value="${dept.name}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-manager" style="width: 200%;" value="${dept.manager}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" style="width: 200%;" value="${dept.phone}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="edit-description">${dept.description} &nbsp;</textarea>
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
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>部门列表</h3>
				</div>
			</div>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover">
				<thead>
					<tr style="color: #B3B3B3;">
						<td><input id="checkAll" type="checkbox" /></td>
						<td>编号</td>
						<td>名称</td>
						<td>负责人</td>
						<td>电话</td>
						<td>描述</td>
					</tr>
				</thead>
				<tbody id="deptBody">
				</tbody>
			</table>
		</div>
		<div style="height: 50px; position: relative;top: 0px; left:30px;">
			<div id="deptPage">

			</div>
		</div>
			
	</div>
	
</body>
</html>