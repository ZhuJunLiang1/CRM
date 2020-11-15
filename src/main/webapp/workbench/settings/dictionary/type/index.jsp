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
	<script type="text/javascript">
		$(function () {
			//为全选复选框绑定事件，触发全选操作
			$("#checkAll").click(function () {
				$("input[name=check]").prop("checked",this.checked);
			})

			//动态生成的元素以 on 方法触发事件
			//语法：$(需要绑定的元素的有效的外层元素).on(事件，jquery对象，函数)
			$("#divTypeBody").on("click",$("input[name=check]"),function () {
				$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
			})
			pageList();

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
							param += "code="+$check[i].value;
							//如果不是最后一条元素需要追加一个&
							if (i<$check.length-1){
								param += "&";
							}
						}
						$.ajax({
							url:"settings/dic/type/delete.do",
							data:param,
							type:"post",
							dataType:"json",
							success:function (data) {
								if(data.success){
									pageList();
								}else {
									alert("删除数据字典值失败");
								}
							}
						})
					}
				}
			})

			$("#editBtn").click(function () {
				//找到复选框中所有选中的的jquery
				var $check = $("input[name=check]:checked");
				if($check.length == 0){
					alert("请选择一条需要编辑的数据！");
				}else if($check.length != 1){
					alert("请选择一条需要编辑的数据！");
				}else {
					window.location.href="settings/dic/type/edit.do?code="+$check.val()+"";
				}
			})

		})
		//局部刷新获取字典值列表
		function pageList() {
			//去掉checkAll勾选状态
			$("#checkAll").prop("check",false);
			$.ajax({
				url:"settings/dic/type/pageList.do",
				type:"get",
				dataType:"json",
				success:function (data) {
					var html = "";
					$.each(data,function (i,n) {
						html += '<tr class="active">'
						html += '<td><input name="check" type="checkbox" value="'+n.code+'" /></td>'
						html += '<td>'+(i+1)+'</td>'
						html += '<td>'+n.code+'</td>'
						html += '<td>'+n.name+'</td>'
						html += '<td>'+n.description+'</td>'
						html += '</tr>'
					})
					$("#divTypeBody").html(html);
				}
			});
		}
	</script>
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典类型列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='workbench/settings/dictionary/type/save.jsp'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="checkAll" type="checkbox" /></td>
					<td>序号</td>
					<td>编码</td>
					<td>名称</td>
					<td>描述</td>
				</tr>
			</thead>
			<tbody id="divTypeBody">
			</tbody>
		</table>
	</div>
	
</body>
</html>