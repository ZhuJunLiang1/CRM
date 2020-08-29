<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String basePath = request.getScheme() + "://" +
request.getServerName() + ":" +
request.getServerPort() +
request.getContextPath() + "/";
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

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
<script type="text/javascript">

	$(function(){
		//时间窗口
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "top-left"
		});
		pageList(1,10);
		//创建按钮事件
		$("#addBtn").click(function () {
			$.ajax({
				url:"workbench/clue/getUserList.do",
				type:"get",
				dataType:"json",
				success:function (data) {
					//整理用户信息列表。
					var html = "<option></option>";
					$.each(data,function (i,n) {
						html += "<option value='"+n.id+"'>"+n.name+"</option>";
					})
					$("#create-owner").html(html);
					var id = "${user.id}";
					$("#create-owner").val(id);
					$("#createClueModal").modal("show");
				}
			})
		})

		//保存按钮事件
		$("#saveBtn").click(function () {
			$.ajax({
				url:"workbench/clue/save.do",
				data:{

					"fullname" :$.trim($("#create-fullname").val()),
					"appellation" :$.trim($("#create-appellation").val()),
					"owner" :$.trim($("#create-owner").val()),
					"company" :$.trim($("#create-company").val()),
					"job" :$.trim($("#create-job").val()),
					"email" :$.trim($("#create-email").val()),
					"phone" :$.trim($("#create-phone").val()),
					"website" :$.trim($("#create-website").val()),
					"mphone" :$.trim($("#create-mphone").val()),
					"state" :$.trim($("#create-state").val()),
					"source" :$.trim($("#create-source").val()),
					"description" :$.trim($("#create-description").val()),
					"contactSummary" :$.trim($("#create-contactSummary").val()),
					"nextContactTime" :$.trim($("#create-nextContactTime").val()),
					"address" :$.trim($("#create-address").val())
				},
				type: "post",
				dataType: "json",
				success:function (data) {
					if(data.success){
						//刷新列表，调用外部方法
						pageList(1,$("#cluePage").bs_pagination('getOption', 'rowsPerPage'));
						$("#clueAddForm")[0].reset();
						//关闭模态窗口
						$("#createClueModal").modal("hide");
					}else {
						alert("添加线索失败");
					}
				}
			})
		})
		//为全选复选框绑定事件，触发全选操作
		$("#checkAll").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})

		$("#clueBody").on("click",$("input[name=check]"),function () {
			$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
		})

		//查询按钮事件
		$("#searchBtn").click(function () {
			/*
            点击查询按钮的时候，应该将搜索框中信息保存，
                使用隐藏域 保存。
            */
			$("#hidden-fullname").val($.trim($("#search-fullname ").val()));
			$("#hidden-company").val($.trim($("#search-company").val()));
			$("#hidden-phone").val($.trim($("#search-phone").val()));
			$("#hidden-source").val($.trim($("#search-source").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-mphone").val($.trim($("#search-mphone").val()));
			$("#hidden-state").val($.trim($("#search-state").val()));
			//回到第一页，维持当前每页数据
			pageList(1,$("#cluePage").bs_pagination('getOption', 'rowsPerPage'));

		})


		//修改按钮事件
		$("#editBtn").click(function () {
			var $check = $("input[name=check]:checked");
			if($check.length ==0 ){
				alert("请选择需要修改的记录");
			}else if($check.length > 1 ){
				alert("只能选择一条记录进行修改");
			}else {
				var id = $check.val();
				$.ajax({
					url:"workbench/clue/getUserListAndClue.do",
					data:{
						"id":id
					},
					type:"get",
					dataType:"json",
					success:function (data) {
						/*
                        data： 用户列表  线索
                            {"uList":[{用户1},{用户二}]，"clue":{线索}}
                        */
						var html = "<option></option>";
						$.each(data.uList,function (i,n) {
							html += "<option value='" + n.id + "'>" + n.name + "</option>"
						})

						$("#edit-owner").html(html);

						//处理单条clue
						$("#edit-id").val(data.clue.id);
						$("#edit-name").val(data.clue.name);
						$("#edit-owner").val(data.clue.owner);
						$("#edit-company").val(data.clue.company);
						$("#edit-appellation").val(data.clue.appellation);
						$("#edit-fullname").val(data.clue.fullname);
						$("#edit-job").val(data.clue.job);
						$("#edit-email").val(data.clue.email);
						$("#edit-phone").val(data.clue.phone);
						$("#edit-website").val(data.clue.website);
						$("#edit-mphone").val(data.clue.mphone);
						$("#edit-state").val(data.clue.state);
						$("#edit-source").val(data.clue.source);
						$("#edit-description").val(data.clue.description);
						$("#edit-contactSummary").val(data.clue.contactSummary);
						$("#edit-nextContactTime").val(data.clue.nextContactTime);
						$("#edit-address").val(data.clue.address);
						$("#editClueModal").modal("show");
					}
				})
			}
		})

		//更新按钮事件
		$("#updateBtn").click(function () {
			$.ajax({
				url:"workbench/clue/update.do",
				data: {
					"id" : $.trim($("#edit-id").val()),
					"name" : $.trim($("#edit-name").val()),
					"owner" : $.trim($("#edit-owner").val()),
					"company" : $.trim($("#edit-company").val()),
					"appellation" : $.trim($("#edit-appellation").val()),
					"fullname" : $.trim($("#edit-fullname").val()),
					"job" : $.trim($("#edit-job").val()),
					"email" : $.trim($("#edit-email").val()),
					"phone" : $.trim($("#edit-phone").val()),
					"website" : $.trim($("#edit-website").val()),
					"mphone" : $.trim($("#edit-mphone").val()),
					"state" : $.trim($("#edit-state").val()),
					"source" : $.trim($("#edit-source").val()),
					"description" : $.trim($("#edit-description").val()),
					"contactSummary" : $.trim($("#edit-contactSummary").val()),
					"nextContactTime" : $.trim($("#edit-nextContactTime").val()),
					"address" : $.trim($("#edit-address").val())
				},
				type: "post",
				dataType: "json",
				success:function (data) {
					/*
                        data{"success":true/false}
                     */
					if(data.success){
						//成功后刷新市场信息列表，局部刷新
						//pageList(1,2);
						pageList($("#cluePage").bs_pagination('getOption', 'currentPage')
								,$("#cluePage").bs_pagination('getOption', 'rowsPerPage'));
						//关闭添加操作模态窗口
						$("#editClueModal").modal("hide");
					}else {
						alert("修改市场活动失败")
					}
				}
			})
		})


		//删除按钮事件
		$("#deleteBtn").click(function () {
			//找到复选框中所有选中的的jquery
			var $check = $("input[name=check]:checked");
			if($check.length == 0){
				alert("请选择需要删除的记录");
			}else {
				if(confirm("确定删除所选中的记录及其备注吗?")){
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
						url:"workbench/clue/delete.do",
						data:param,
						type:"post",
						dataType:"json",
						success:function (data) {
							if(data.success){
								//回到第一页，维持 每页展现记录数
								pageList(1,$("#cluePage").bs_pagination('getOption', 'rowsPerPage'));
							}else {
								alert("删除市场活动失败");
							}
						}
					})
				}
			}
		})

	});
	function pageList(pageNo,pageSize) {
		//去掉checkAll勾选状态
		$("#checkAll").prop("check",false);
		//查询前将隐藏域中保存信息取出来，重新赋予到搜索框中
		$("#search-fullname").val($.trim($("#hidden-fullname ").val()));
		$("#search-company").val($.trim($("#hidden-company").val()));
		$("#search-phone").val($.trim($("#hidden-phone").val()));
		$("#search-source").val($.trim($("#hidden-source").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-mphone").val($.trim($("#hidden-mphone").val()));
		$("#search-state").val($.trim($("#hidden-state").val()));
		$.ajax({
			url: "workbench/clue/pageList.do",
			data: {
				"pageNo": pageNo,
				"pageSize": pageSize,
				"fullname": $.trim($("#search-fullname").val()),
				"company": $.trim($("#search-company").val()),
				"phone": $.trim($("#search-phone").val()),
				"source": $.trim($("#search-source").val()),
				"owner": $.trim($("#search-owner").val()),
				"mphone": $.trim($("#search-mphone").val()),
				"state": $.trim($("#search-state").val())
			},
			type: "get",
			dataType: "json",
			success: function (data) {
				/*
                    市场活动信息列表
                    分页插件需要的 ，查询出来的总记录数
                    {“total”：100,"dataList":[{市场活动1}，]}
                 */
				var html = "";
				$.each(data.dataList, function (i, n) {
					html += '<tr>';
					html += '<td><input type="checkbox" name="check" value="' + n.id + '" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/clue/detail.do?id=' + n.id + '\';">' + n.fullname + '</a></td>';
					html += '<td>' + n.company + '</td>';
					html += '<td>' + n.phone + '</td>';
					html += '<td>' + n.mphone + '</td>';
					html += '<td>' + n.source + '</td>';
					html += '<td>' + n.owner + '</td>';
					html += '<td>' + n.state + '</td>';
					html += '</tr>';
				})
				$("#clueBody").html(html);
				//计算总页数
				var totalPages = data.total % pageSize == 0 ? data.total / pageSize : parseInt(data.total / pageSize) + 1;

				$("#cluePage").bs_pagination({
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
					onChangePage: function (event, data) {
						pageList(data.currentPage, data.rowsPerPage);
					}
				});
			}
		});
	}


		

	
</script>
</head>
<body>
<input type="hidden" id="hidden-fullname">
<input type="hidden" id="hidden-company">
<input type="hidden" id="hidden-phone">
<input type="hidden" id="hidden-source">
<input type="hidden" id="hidden-owner">
<input type="hidden" id="hidden-mphone">
<input type="hidden" id="hidden-state">
	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form"  id="clueAddForm">
					
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">
								</select>
							</div>
							<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-appellation">
								  <option></option>
									<c:forEach items="${appellation}" var="a">
									<option value="${a.value}">${a.text}</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-fullname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-fullname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
							<label for="create-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
							<label for="create-state" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-state">
								  <option></option>
									<c:forEach items="${clueState}" var="c">
										<option value="${c.value}">${c.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source">
								  <option></option>
									<c:forEach items="${source}" var="s">
										<option value="${s.value}">${s.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">线索描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>
						
						<div style="position: relative;top: 20px;">
							<div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address"></textarea>
                                </div>
							</div>
						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"  id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-id"/>
						<div class="form-group">
							<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">
								</select>
							</div>
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-appellation">
								  <option></option>
									<c:forEach items="${appellation}" var="a">
										<option value="${a.value}">${a.text}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-fullname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-fullname" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="">
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" value="010-84846003">
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="12345678901">
							</div>
							<label for="edit-state" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-state">
								  <option></option>
									<c:forEach items="${clueState}" var="c">
										<option value="${c.value}">${c.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
								  <option></option>
									<c:forEach items="${source}" var="s">
										<option value="${s.value}">${s.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="edit-nextContactTime" value="">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address"></textarea>
                                </div>
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
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>线索列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-fullname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司</div>
				      <input class="form-control" type="text" id="search-company">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="search-phone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索来源</div>
					  <select class="form-control" id="search-source">
						  <option></option>
						  <c:forEach items="${source}" var="s">
							  <option value="${s.value}">${s.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>
				  
				  
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">手机</div>
				      <input class="form-control" type="text" id="search-mphone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索状态</div>
					  <select class="form-control" id="search-state">
						  <option></option>
						  <c:forEach items="${clueState}" var="c">
							  <option value="${c.value}">${c.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>

				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>名称</td>
							<td>公司</td>
							<td>公司座机</td>
							<td>手机</td>
							<td>线索来源</td>
							<td>所有者</td>
							<td>线索状态</td>
						</tr>
					</thead>
					<tbody id="clueBody">
<%--						<tr>--%>
<%--							<td><input type="checkbox" /></td>--%>
<%--							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/clue/detail.jsp';">李四先生</a></td>--%>
<%--							<td>动力节点</td>--%>
<%--							<td>010-84846003</td>--%>
<%--							<td>12345678901</td>--%>
<%--							<td>广告</td>--%>
<%--							<td>zhangsan</td>--%>
<%--							<td>已联系</td>--%>
<%--						</tr>--%>
<%--                        <tr class="active">--%>
<%--                            <td><input type="checkbox" /></td>--%>
<%--                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/clue/detail.jsp';">李四先生</a></td>--%>
<%--                            <td>动力节点</td>--%>
<%--                            <td>010-84846003</td>--%>
<%--                            <td>12345678901</td>--%>
<%--                            <td>广告</td>--%>
<%--                            <td>zhangsan</td>--%>
<%--                            <td>已联系</td>--%>
<%--                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 60px;">
				<div id="cluePage">

				</div>
			</div>
			
		</div>
		
	</div>
</body>
</html>