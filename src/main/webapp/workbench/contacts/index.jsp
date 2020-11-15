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
	<script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
<script type="text/javascript">

	$(function(){
		$("#create-customerName").typeahead({
			source: function (query, process) {
				$.get(
						"workbench/contacts/getCustomerName.do",
						{ "name" : query },
						function (data) {
							/*
                                data : [{客户名称1}，{客户名称2}]
                             */
							//alert(data);
							process(data);
						},
						"json"
				);
			},
			delay: 1500
		});
		$("#edit-customerName").typeahead({
			source: function (query, process) {
				$.get(
						"workbench/contacts/getCustomerName.do",
						{ "name" : query },
						function (data) {
							/*
                                data : [{客户名称1}，{客户名称2}]
                             */
							//alert(data);
							process(data);
						},
						"json"
				);
			},
			delay: 1500
		});
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		pageList(1,10);
		$("#searchBtn").click(function () {
			/*
            点击查询按钮的时候，应该将搜索框中信息保存，
                使用隐藏域 保存。
            */
			$("#hidden-fullname").val($.trim($("#search-fullname ").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-customerId").val($.trim($("#search-customerId").val()));
			$("#hidden-birth").val($.trim($("#search-birth").val()));
			$("#hidden-source").val($.trim($("#search-source").val()));
			//回到第一页，维持当前每页数据
			pageList(1,$("#contactsPage").bs_pagination('getOption','rowsPerPage'));
		})
		$("#checkAll").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})
		$("#contactsBody").on("click",$("input[name=check]"),function () {
			$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
		})

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
						url:"workbench/contacts/delete.do",
						data:param,
						type:"post",
						dataType:"json",
						success:function (data) {
							if(data.success){
								//回到第一页，维持 每页展现记录数
								pageList(1,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));
							}else {
								alert("删除联系人失败");
							}
						}
					})
				}
			}
		})
		$("#addBtn").click(function () {
			$.ajax({
				url:"workbench/contacts/getUserList.do",
				type:"get",
				dataType:"json",
				success:function (data) {
					var html = "<option></option>";
					$.each(data,function (i,n) {
						html += "<option value='"+n.id+ "'>" + n.name + "</option>";
					})
					$("#create-owner").html(html);
					/*
						将当前登录的用户，设为下拉框默认的选项
					 */
					//在JS中使用EL表达式 一定要套用在字符串中
					$("#create-owner").val("${sessionScope.user.id}");
					$("#createContactsModal").modal("show");
				}
			})
		})
		$("#saveBtn").click(function () {
			$.ajax({
				url:"workbench/contacts/save.do",
				data: {
					"owner":$.trim($("#create-owner").val()),
					"fullname":$.trim($("#create-fullname").val()),
					"source":$.trim($("#create-source").val()),
					"appellation":$.trim($("#create-appellation").val()),
					"job":$.trim($("#create-job").val()),
					"mphone":$.trim($("#create-mphone").val()),
					"email":$.trim($("#create-email").val()),
					"birth":$.trim($("#create-birth").val()),
					"customerName":$.trim($("#create-customerName").val()),
					"contactSummary":$.trim($("#create-contactSummary").val()),
					"description":$.trim($("#create-description").val()),
					"nextContactTime":$.trim($("#create-nextContactTime").val()),
					"address":$.trim($("#create-address").val())
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
						/*
                            ($("#activityPage").bs_pagination('getOption', 'currentPage')
                            操作后停留在当前页
                            $("#activityPage").bs_pagination('getOption', 'rowsPerPage')
                            操作后位置已经设置好的每页展现的记录数
                        */
						pageList(1,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));

						//清空添加操作模态窗口数据
						/*
							拿到了jquery对象，但是只有submit方法可用， reset方法无用
							JS原生DOM对象有 reset方法
							jquery转换DOM
								jquery对象【0】
							dom转换成jquery
								$(dom)为jquery
						 */
						$("#contactsAddForm")[0].reset();
						//关闭添加操作模态窗口
						$("#createContactsModal").modal("hide");
					}else {
						alert("添加市场活动失败")
					}
				}
			})
		})
		$("#editBtn").click(function () {
			var $check = $("input[name=check]:checked");
			if($check.length ==0 ){
				alert("请选择需要修改的记录");
			}else if($check.length > 1 ){
				alert("只能选择一条记录进行修改");
			}else {
				var id = $check.val();
				$.ajax({
					url:"workbench/contacts/getUserListAndContacts.do",
					data:{
						"id":id
					},
					type:"get",
					dataType:"json",
					success:function (data) {
						var html = "<option></option>";
						$.each(data.uList,function (i,n) {
							html += "<option value='" + n.id + "'>" + n.name + "</option>"
						})

						$("#edit-owner").html(html);
						$("#edit-owner").val(data.contacts.owner);

						$("#edit-id").val(data.contacts.id);
						$("#edit-fullname").val(data.contacts.fullname);
						$("#edit-source").val(data.contacts.source);
						$("#edit-appellation").val(data.contacts.appellation);
						$("#edit-mphone").val(data.contacts.mphone);
						$("#edit-job").val(data.contacts.job);
						$("#edit-email").val(data.contacts.email);
						$("#edit-customerName").val(data.contacts.customerId);
						$("#edit-birth").val(data.contacts.birth);
						$("#edit-contactSummary").val(data.contacts.contactSummary);
						$("#edit-description").val(data.contacts.description);
						$("#edit-nextContactTime").val(data.contacts.nextContactTime);
						$("#edit-address").val(data.contacts.address);
						$("#editContactsModal").modal("show");
					}
				})
			}
		})
		$("#updateBtn").click(function () {
			$.ajax({
				url:"workbench/contacts/update.do",
				data:{
					"id":$("#edit-id").val(),
					"owner":$.trim($("#edit-owner").val()),
					"fullname":$.trim($("#edit-fullname").val()),
					"source":$.trim($("#edit-source").val()),
					"appellation":$.trim($("#edit-appellation").val()),
					"job":$.trim($("#edit-job").val()),
					"mphone":$.trim($("#edit-mphone").val()),
					"email":$.trim($("#edit-email").val()),
					"birth":$.trim($("#edit-birth").val()),
					"customerName":$.trim($("#edit-customerName").val()),
					"contactSummary":$.trim($("#edit-contactSummary").val()),
					"description":$.trim($("#edit-description").val()),
					"nextContactTime":$.trim($("#edit-nextContactTime").val()),
					"address":$.trim($("#edit-address").val())
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					if(data.success){
						pageList($("#contactsPage").bs_pagination('getOption', 'currentPage')
								,$("#contactsPage").bs_pagination('getOption', 'rowsPerPage'));
						$("#editContactsModal").modal("hide");
					}else {
						$("#editContactsModal").modal("hide");
						alert("修改信息失败")
					}

				}
			})
		})
	});
	function pageList(pageNo,pageSize) {
		$("#checkAll").prop("check",false);
		//查询前将隐藏域中保存信息取出来，重新赋予到搜索框中
		$("#search-fullname").val($.trim($("#hidden-fullname ").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-customerId").val($.trim($("#hidden-customerId").val()));
		$("#search-birth").val($.trim($("#hidden-birth").val()));
		$("#search-source").val($.trim($("#hidden-source").val()));

		$.ajax({
			url:"workbench/contacts/pageList.do",
			data:{
				"pageNo":pageNo,
				"pageSize":pageSize,
				"fullname":$.trim($("#search-fullname").val()),
				"owner":$.trim($("#search-owner").val()),
				"customerId":$.trim($("#search-customerId").val()),
				"birth":$.trim($("#search-birth").val()),
				"source":$.trim($("#search-source").val())
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				var html = "";
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="check" value="'+n.id+'" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/contacts/detail.do?id='+n.id+'\';">'+n.fullname+'</a></td>';
					html += '<td>'+n.customerId+'</td>';
					html += '<td>'+n.owner+'</td>';
					html += '<td>'+n.source+'</td>';
					html += '<td>'+n.birth+'</td>';
					html += '</tr>';
				})
				$("#contactsBody").html(html);
				//计算总页数
				var totalPages = data.total%pageSize == 0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;

				//数据处理完毕后，结合分页插件，
				$("#contactsPage").bs_pagination({
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
		})
	}
</script>
</head>
<body>
<input type="hidden" id="hidden-fullname">
<input type="hidden" id="hidden-owner">
<input type="hidden" id="hidden-customerId">
<input type="hidden" id="hidden-birth">
<input type="hidden" id="hidden-source">
	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="contactsAddForm">
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">
								</select>
							</div>
							<label for="create-source" class="col-sm-2 control-label">来源</label>
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
							<label for="create-fullname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-fullname">
							</div>
							<label for="create-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-appellation">
								  <option></option>
									<c:forEach items="${appellation}" var="a">
										<option value="${a.value}">${a.text}</option>
									</c:forEach>
								</select>
							</div>
							
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-birth">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
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
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">
								</select>
							</div>
							<label for="edit-source" class="col-sm-2 control-label">来源</label>
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
							<label for="edit-fullname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-fullname">
							</div>
							<label for="edit-appellation" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-appellation">
								  <option></option>
									<c:forEach items="${appellation}" var="a">
										<option value="${a.value}">${a.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="CTO">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建">
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
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="edit-nextContactTime">
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

	<!-- 联系人列表 -->
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" type="text" id="search-fullname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="search-customerId">
				    </div>
				  </div>

				  <br>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="search-source">
						  <option></option>
						  <c:forEach items="${source}" var="s">
							  <option value="${s.value}">${s.text}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
				      <input class="form-control time" type="text" id="search-birth">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>

			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn" ><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
			</div>

			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>姓名</td>
							<td>客户名称</td>
							<td>所有者</td>
							<td>来源</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="contactsBody">
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 10px;">
				<div id="contactsPage">
				</div>
			</div>
			
		</div>
		
	</div>
</body>
</html>