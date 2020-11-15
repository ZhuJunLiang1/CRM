<%@ page import="java.util.Set" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" +
request.getServerName() + ":" +
request.getServerPort() +
request.getContextPath() + "/";
	Map<String,String> pMap = (Map<String,String>)application.getAttribute("pMap");
	Set<String> set = pMap.keySet();
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
	<script>
		var json = {
			<%
                for (String key:set){
                    String value = pMap.get(key);
            %>
			"<%=key%>" : <%=value%>,
			<%
                }
            %>
		};
		$(function () {
			$(".time1").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "top-left"
			});
			$(".time2").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});
			$("#edit-stage").change(function () {
				//取得选中的阶段
				var stage = $("#edit-stage").val();
				//通过stage 取得可能性
				//pMap是java中的map对象   将pMap 转换成js中的键值对关系
				//取可能性   json.key 取不了value
				//因为 stage是一个可变的变量 不能以传统的json.key取值
				//要以json【key】 取值
				var possibility = json[stage];
				$("#edit-possibility").val(possibility);
			})
			$("#submitActivityBtn").click(function () {
				//取得选中的市场活动的id
				var $check = $("input[name=check1]:checked");
				var id = $check.val();
				var name = $("#"+id).html();
				//将内容填充到
				$("#edit-activityName").val(name);
				$("#activityId").val(id);
				$("#searchActivityModal").modal("hide");
			})
			$("#searchActivity").keydown(function (event) {
				if(event.keyCode == 13){
					$.ajax({
						url:"workbench/transaction/getActivityListByName.do",
						data:{
							"activityName": $.trim($("#searchActivity").val())
						},
						type:"get",
						dataType:"json",
						success:function (data) {
							//List Activity
							var html = "";
							$.each(data,function (i,n) {
								html += '<tr>'
								html += '<td><input type="radio" name="check1" value="'+n.id+'" /></td>'
								html += '<td id="'+n.id+'">'+n.name+'</td>'
								html += '<td>'+n.startDate+'</td>'
								html += '<td>'+n.endDate+'</td>'
								html += '<td>'+n.owner+'</td>'
								html += '</tr>'
							})
							$("#activitySearchBody").html(html);
						}
					})
					return false;
				}
			})
			$("#submitContactsBtn").click(function () {
				//取得选中的市场活动的id
				var $check = $("input[name=check2]:checked");
				var id = $check.val();
				var name = $("#"+id).html();
				//将内容填充到
				$("#edit-contactsName").val(name);
				$("#contactsId").val(id);
				$("#findContacts").modal("hide");
			})
			$("#searchContacts").keydown(function (event) {
				if(event.keyCode == 13){
					$.ajax({
						url:"workbench/transaction/getContactsListByName.do",
						data:{
							"contactsName": $.trim($("#searchContacts").val())
						},
						type:"get",
						dataType:"json",
						success:function (data) {
							//List Activity
							var html = "";
							$.each(data,function (i,n) {
								html += '<tr>'
								html += '<td><input type="radio" name="check2" value="'+n.id+'" /></td>'
								html += '<td id="'+n.id+'">'+n.fullname+'</td>'
								html += '<td>'+n.email+'</td>'
								html += '<td>'+n.mphone+'</td>'
								html += '</tr>'
							})
							$("#searchContactsBody").html(html);
						}
					})
					return false;
				}
			})
			$("#updateBtn").click(function () {
				$("#updateTanForm").submit();
			})
		})
	</script>
</head>
<body>

<!-- 查找联系人 -->
<div class="modal fade" id="findContacts" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">查找联系人</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" id="searchContacts" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="contactsTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>邮箱</td>
						<td>手机</td>
					</tr>
					</thead>
					<tbody id="searchContactsBody">

					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="submitContactsBtn">提交</button>
			</div>

		</div>
	</div>
</div>
<!-- 查找市场活动 -->
<div class="modal fade" id="searchActivityModal" role="dialog" >
	<div class="modal-dialog" role="document" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">搜索市场活动</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" id="searchActivity" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>开始日期</td>
						<td>结束日期</td>
						<td>所有者</td>
						<td></td>
					</tr>
					</thead>
					<tbody id="activitySearchBody">
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="submitActivityBtn">提交</button>
			</div>
		</div>
	</div>
</div>


<div style="position:  relative; left: 30px;">
		<h3>更新交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="updateBtn" class="btn btn-primary">更新</button>
			<button type="button" onclick="window.history.back()" class="btn btn-default">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" action="workbench/transaction/update.do" method="post" id="updateTanForm" role="form" style="position: relative; top: -30px;">
		<div class="form-group">
			<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<input type="hidden" name="id" value="${tran.id}">
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="edit-owner" name="owner">
					<c:forEach items="${uList}" var="u">
						<option value="${u.id}" ${tran.owner eq u.name ? "selected": ""} >${u.name}</option>
					</c:forEach>
				</select>
			</div>
			<label for="edit-money" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="money" id="edit-money" value="${tran.money}">
			</div>
		</div>
		<div class="form-group">
			<label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="name" id="edit-name" value="${tran.name}">
			</div>
			<label for="edit-expectedDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control time2" name="expectedDate" id="edit-expectedDate" value="${tran.expectedDate}">
			</div>
		</div>
		<div class="form-group">
			<label for="edit-customerName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="customerName" id="edit-customerName" value="${tran.customerId}" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="edit-stage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" name="stage" id="edit-stage">
			  	<option></option>
				  <c:forEach items="${stage}" var="stage">
					  <option value="${stage.value}" ${tran.stage eq stage.text ? "selected": ""}>${stage.text}</option>
				  </c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-type" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" name="type" id="edit-type">
				  <option></option>
					<c:forEach items="${transactionType}" var="type">
						<option value="${type.value}" ${tran.type eq type.text ? "selected": ""}>${type.text}</option>
					</c:forEach>
				</select>
			</div>
			<label for="edit-possibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="possibility" id="edit-possibility" value="${tran.possibility}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" name="source" id="edit-clueSource">
				  <option></option>
					<c:forEach items="${source}" var="source">
						<option value="${source.value}" ${tran.source eq source.text ? "selected": ""}>${source.text}</option>
					</c:forEach>
				</select>
			</div>
			<label for="edit-activityName" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#searchActivityModal"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-activityName" value="${tran.activityId}">
				<input type="hidden" name="activityId" id="activityId" value="${activityId}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-contactsName" value="${tran.contactsId}">
				<input type="hidden" name="contactsId" id="contactsId" value="${contactsId}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-description" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" name="description" id="edit-description">${tran.description}</textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" name="contactsSummary" id="edit-contactSummary">${tran.contactSummary}&nbsp;</textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control time1" name="nextContactTime" id="edit-nextContactTime" value="${tran.nextContactTime}">
			</div>
		</div>

	</form>
</body>
</html>