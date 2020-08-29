<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-phone").val($.trim($("#search-phone").val()));
			$("#hidden-website").val($.trim($("#search-website").val()));
			//回到第一页，维持当前每页数据
			pageList(1,$("#customerPage").bs_pagination('getOption','rowsPerPage'));
		})
		$("#checkAll").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})
		$("#customerBody").on("click",$("input[name=check]"),function () {
			$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
		})

		$("#addBtn").click(function () {
			/*操作模态窗口的方式：
			操作模态窗口的jquery对象，调用modal方法 为该方法传参 show：打开 hide：关闭
			 */
			//$("#createActivityModal").modal("show");
			//走后台取得用户信息列表，所有者下拉框填填充数值
			$.ajax({
				url:"workbench/customer/getUserList.do",
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
					$("#createCustomerModal").modal("show");
				}
			})
		})
		$("#saveBtn").click(function () {
			$.ajax({
				url:"workbench/customer/save.do",
				data: {
					"owner":$.trim($("#create-owner").val()),
					"name":$.trim($("#create-name").val()),
					"website":$.trim($("#create-website").val()),
					"phone":$.trim($("#create-phone").val()),
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
						pageList(1,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));

						//清空添加操作模态窗口数据
						/*
							拿到了jquery对象，但是只有submit方法可用， reset方法无用
							JS原生DOM对象有 reset方法
							jquery转换DOM
								jquery对象【0】
							dom转换成jquery
								$(dom)为jquery
						 */
						$("#customerAddForm")[0].reset();
						//关闭添加操作模态窗口
						$("#createCustomerModal").modal("hide");
					}else {
						alert("添加市场活动失败")
					}
				}
			})
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
						url:"workbench/customer/delete.do",
						data:param,
						type:"post",
						dataType:"json",
						success:function (data) {
							if(data.success){
								//回到第一页，维持 每页展现记录数
								pageList(1,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));
							}else {
								alert("删除市场活动失败");
							}
						}
					})
				}
			}
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
					url:"workbench/customer/getUserListAndCustomer.do",
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

						$("#edit-id").val(data.customer.id);
						$("#edit-name").val(data.customer.name);
						$("#edit-owner").val(data.customer.owner);
						$("#edit-website").val(data.customer.website);
						$("#edit-phone").val(data.customer.phone);
						$("#edit-contactSummary").val(data.customer.contactSummary);
						$("#edit-description").val(data.customer.description);
						$("#edit-nextContactTime").val(data.customer.nextContactTime);
						$("#edit-address").val(data.customer.address);
						$("#editCustomerModal").modal("show");
					}
				})
			}
		})

		//为更新按钮绑定事件，执行市场活动的修改操作
		$("#updateBtn").click(function () {
			$.ajax({
				url:"workbench/customer/update.do",
				data: {
					"id" : $.trim($("#edit-id").val()),
					"owner" : $.trim($("#edit-owner").val()),
					"name" : $.trim($("#edit-name").val()),
					"website" : $.trim($("#edit-website").val()),
					"phone" : $.trim($("#edit-phone").val()),
					"contactSummary" : $.trim($("#edit-contactSummary").val()),
					"description" : $.trim($("#edit-description").val()),
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
						pageList($("#customerPage").bs_pagination('getOption', 'currentPage')
								,$("#customerPage").bs_pagination('getOption', 'rowsPerPage'));
						//关闭添加操作模态窗口
						$("#editCustomerModal").modal("hide");
					}else {
						alert("修改客户信息失败")
					}
				}
			})
		})

	});
	//局部刷新获取活动列表
	function pageList(pageNo,pageSize) {
		//去掉checkAll勾选状态
		$("#checkAll").prop("check",false);
		//查询前将隐藏域中保存信息取出来，重新赋予到搜索框中
		$("#search-name").val($.trim($("#hidden-name ").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#search-phone").val($.trim($("#hidden-phone").val()));
		$("#search-website").val($.trim($("#hidden-website").val()));
		$.ajax({
			url:"workbench/customer/pageList.do",
			data:{
				"pageNo":pageNo,
				"pageSize":pageSize,
				"name":$.trim($("#search-name").val()),
				"owner":$.trim($("#search-owner").val()),
				"phone":$.trim($("#search-phone").val()),
				"website":$.trim($("#search-website").val())
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				var html = "";
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="check" value="'+n.id+'" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/customer/detail.do?id='+n.id+'\';">'+n.name+'</a></td>';
					html += '<td>'+n.owner+'</td>';
					html += '<td>'+n.phone+'</td>';
					html += '<td>'+n.website+'</td>';
					html += '</tr>';
				})
				$("#customerBody").html(html);
				//计算总页数
				var totalPages = data.total%pageSize == 0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;

				//数据处理完毕后，结合分页插件，
				$("#customerPage").bs_pagination({
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
<input type="hidden" id="hidden-name">
<input type="hidden" id="hidden-owner">
<input type="hidden" id="hidden-phone">
<input type="hidden" id="hidden-website">
	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="customerAddForm">
					
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">
								</select>
							</div>
							<label for="create-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-name">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-website">
                            </div>
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone">
							</div>
						</div>
						<div class="form-group">
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
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">

					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
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
							<label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" >
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-website" >
                            </div>
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone">
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
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
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
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
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
				      <div class="input-group-addon">公司网站</div>
				      <input class="form-control" type="text" id="search-website">
				    </div>
				  </div>
				  
				  <button  class="btn btn-default" type="button" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox"  id="checkAll"/></td>
							<td>名称</td>
							<td>所有者</td>
							<td>公司座机</td>
							<td>公司网站</td>
						</tr>
					</thead>
					<tbody id="customerBody">
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="customerPage">
				</div>

			</div>
			
		</div>
		
	</div>
</body>
</html>