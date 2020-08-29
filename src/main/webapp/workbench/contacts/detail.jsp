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
<meta charset="UTF-8">
	<base href="<%=basePath%>">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript" src="jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
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
		$(".time1").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "bottom-left"
		});
		$(".time2").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "top-left"
		});
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});

		$("#deleteContacts").click(function () {
			if(confirm("您确定要删除该条联系人及其相关备注、交易及活动关系么？")){
				$.ajax({
					url:"workbench/contacts/delete.do",
					data:"id="+$("#detail-id").val(),
					type:"post",
					dataType:"json",
					success:function (data) {
						if(data.success){
							//回到第一页，维持 每页展现记录数
							window.location.href="workbench/contacts/index.jsp";
						}else {
							alert("删除联系人失败");
						}
					}
				})
			}
		})

		$("#editBtn").click(function () {
				var id =$("#detail-id").val();
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
						//局部刷新详情页面信息
						$.ajax({
							url:"workbench/contacts/getDetailById.do",
							data:{
								"id":$("#edit-id").val()
							},
							type:"get",
							dataType:"json",
							success:function (data1) {
								$("#title-name").html(data1.fullname+"&nbsp;"+data1.appellation+"<samll>"+data1.customerId+"&nbsp;</small>");
								$("#detail-owner").html(data1.owner);
								$("#detail-source").html(data1.source);
								$("#detail-customerName").html(data1.customerId);
								$("#detail-fullname").html(data1.fullname);
								$("#detail-email").html(data1.email);
								$("#detail-mphone").html(data1.mphone);
								$("#detail-job").html(data1.job);
								$("#detail-birth").html(data1.birth);
								$("#detail-editBy").html(data1.editBy);
								$("#detail-editTime").html(data1.editTime);
								$("#detail-description").html(data1.description);
								$("#detail-contactSummary").html(data1.contactSummary);
								$("#detail-nextContactTime").html(data1.nextContactTime);
								$("#detail-address").html(data1.address);
								$("#editContactsModal").modal("hide");
							}
						})
					}else {
						$("#editContactsModal").modal("hide");
						alert("修改信息失败")
					}
				}
			})
		})
		showRemarkList();
		showTranList();
        showActivityList();
		$("#saveRemarkBtn").click(function () {
			$.ajax({
				url:"workbench/contacts/saveRemark.do",
				data:{
					"noteContent":$.trim($("#remark").val()),
					"contactsId": "${contacts.id}",
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					if(data.success){
						var html = "";
						html += '<div id="'+data.contactsRemark.id+'" class="remarkDiv" style="height: 60px;">';
						html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
						html += '<div style="position: relative; top: -40px; left: 40px;" >';
						html += '<h5 id="e'+data.contactsRemark.id+'">'+ data.contactsRemark.noteContent+'</h5>';
						html += '<font color="gray">联系人</font> <font color="gray">-</font> <b>${contacts.fullname}</b> <small style="color: gray;" id="s'+data.contactsRemark.id+'" > '+(data.contactsRemark.createTime)+' 由'+(data.contactsRemark.createBy+'创建')+'</small>';
						html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
						html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+data.contactsRemark.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '&nbsp;&nbsp;&nbsp;&nbsp;';
						html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.contactsRemark.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '</div>';
						html += '</div>';
						html += '</div>';
						$("#remarkDiv").before(html);
						$("#remark").val("");
					}else {
						alert("添加备注失败！");
					}
				}
			})
		})
		//备注更新按钮事件
		$("#updateRemarkBtn").click(function () {
			var id = $("#remarkId").val();
			$.ajax({
				url:"workbench/contacts/updateRemark.do",
				data:{
					"id" : id,
					"noteContent": $.trim($("#noteContent").val())
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					/*
                        success: T/F activityRemark 信息
                     */
					if(data.success){
						//更新DIV中相应的信息。 只用更新 noteContent,editTime
						//editBy
						$("#e"+id).html(data.contactsRemark.noteContent);
						$("#s"+id).html(data.contactsRemark.editTime + "由"+ data.contactsRemark.editBy+"修改");
						$("#editRemarkModal").modal("hide");
					}else {
						alert("修改备注失败！");
					}
				}
			})
		})

		$("#activitySearchBody").on("click",$("input[name=check]"),function () {
			$("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
		})
		$("#checkAll").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})
		$("#searchActivity").keydown(function (event) {
			if(event.keyCode == 13){
				$.ajax({
					url:"workbench/contacts/getActivityListByNameAndNotByContactsId.do",
					data:{
						"activityName": $.trim($("#searchActivity").val()),
						"contactsId": "${contacts.id}"
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						var html = "";
						//	List<Activity>
						$.each(data,function (i,n) {
							html += '<tr>'
							html += '<td><input type="checkbox" name="check" value="'+n.id+'" /></td>'
							html += '<td>'+n.name+'</td>'
							html += '<td>'+n.startDate+'</td>'
							html += '<td>'+n.endDate+'</td>'
							html += '<td>'+n.owner+'</td>'
							html += '</tr>'
						})
						$("#activitySearchBody").html(html);
					}
				})
				//展现完列表后，将模态窗口默认回车清数据行为禁言
				return false;
			}
		})
		$("#bundBtn").click(function () {
			var $checkAll = $("input[name=check]:checked");
			if($checkAll.length == 0){
				alert("请选择需要关联的市场活动");
			}else {
				//clueID  一个  N个activityId
				var param = "contactsId=${contacts.id}&";
				for(var i=0;i<$checkAll.length;i++){
					param += "activityId="+$($checkAll[i]).val();
					if(i<$checkAll.length - 1){
						param +="&";
					}
				}
				$.ajax({
					url:"workbench/contacts/bundActivity.do",
					data:param,
					type:"post",
					dataType:"json",
					success:function (data) {
						if(data.success){
							//刷新关联市场活动列表
							showActivityList();
							//搜索框清除
							$("#searchActivity").val();
							//全选撤回
							$("#checkAll").prop("check",false);
							//清除数据
							$("#activitySearchBody").html("");
							//关闭窗口
							$("#bundActivityModal").modal("hide");
						}else {
							alert("关联市场活动失败！");
						}
					}
				})
			}
		})
	});
	function editRemark(id) {
		$("#remarkId").val(id);
		var noteContent = $("#e"+id).html();
		//将展现出来的信息，赋予到修改操作模态窗口
		$("#noteContent").val(noteContent);
		$("#editRemarkModal").modal("show");
	}
	function showRemarkList() {
		$.ajax({
			url:"workbench/contacts/getRemarkListByContactsId.do",
			data:{
				"contactsId":"${contacts.id}"
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				var html = "";
				$.each(data,function (i,n) {
					/*
                        javascript:void(0);
                            将超链接禁用，只能以触发事件的形式来操作
                     */
					html += '<div id="'+n.id+'" class="remarkDiv" style="height: 60px;">';
					html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
					html += '<div style="position: relative; top: -40px; left: 40px;" >';
					html += '<h5 id="e'+n.id+'">'+ n.noteContent+'</h5>';
					html += '<font color="gray">联系人</font> <font color="gray">-</font> <b>${contacts.fullname}</b> <small style="color: gray;" id="s'+n.id+'"> '+(n.editFlag == 0? n.createTime:n.editTime)+' 由'+(n.editFlag == 0? n.createBy+'创建':n.editBy+'修改')+'</small>';
					html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
					html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '&nbsp;&nbsp;&nbsp;&nbsp;';
					html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
				})
				$("#remarkDiv").before(html);

				$("#remarkBody").on("mouseover",".remarkDiv",function(){
					$(this).children("div").children("div").show();
				})
				$("#remarkBody").on("mouseout",".remarkDiv",function(){
					$(this).children("div").children("div").hide();
				})
			}

		})
	}
	function deleteRemark(id) {
		$.ajax({
			url:"workbench/contacts/deleteRemarkById.do",
			data:{
				"id" : id
			},
			type:"post",
			dataType:"json",
			success:function (data) {
				if(data.success){
					//记录使用的是before方法，每一次删除后会保留所有数据
					// showRemarkList();
					$("#"+id).remove();
				}else {
					alert("删除失败");
				}
			}
		})
	}
	function showTranList() {
		$.ajax({
			url:"workbench/contacts/getTranListByContactsId.do",
			data:{
				"contactsId":"${contacts.id}"
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				var html = "";
				$.each(data,function (i,n) {
					html += '<tr >';
					html += '<td><a href="workbench/transaction/detail.do?id='+n.id+'" style="text-decoration: none;">'+n.name+'</a></td>';
					html += '<td>'+n.money+'</td>';
					html += '<td>'+n.stage+'</td>';
					html += '<td>'+n.possibility+'</td>';
					html += '<td>'+n.expectedDate+'</td>';
					html += '<td>'+n.type+'</td>';
					html += '<td><a href="javascript:void(0);" onclick="deleteTran(\''+n.id+'\')" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>';
					html += '</tr>';
				})
				$("#tranBody").html(html);
			}
		})
	}
    function showActivityList() {
        $.ajax({
            url:"workbench/contacts/getActivityListByContactsId.do",
            data:{
                "contactsId":"${contacts.id}"
            },
            type:"get",
            dataType:"json",
            success:function (data) {
                var html = "";
                $.each(data,function (i,n) {
                    html += '<tr >';
                    html += '<td><a href="workbench/activity/detail.do?id='+n.id+'" style="text-decoration: none;">'+n.name+'</a></td>';
                    html += '<td>'+n.startDate+'</td>';
                    html += '<td>'+n.endDate+'</td>';
                    html += '<td>'+n.owner+'</td>';
                    html += '<td><a href="javascript:void(0);" onclick="unBundActivity(\''+n.id+'\')" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>';
                    html += '</tr>';
                })
                $("#activityBody").html(html);
            }
        })
    }
    function unBundActivity(id) {
	    $("#unbundActivityModal").modal("show");
        $("#unbundActivityBtn").click(function () {
            $.ajax({
                url:"workbench/contacts/unbundActivity.do",
                data:{
                    "activityId" : id ,
                    "contactsId" : $("#detail-id").val()
                },
                type:"post",
                dataType:"json",
                success:function (data) {
                    if(data.success){
                        showActivityList();
                        $("#unbundActivityModal").modal("hide");
                    }else {
                        $("#unbundActivityModal").modal("hide");
                        alert("删除该条活动失败！")
                    }
                }
            })
        })

    }
	function deleteTran(id) {
		$("#removeTransactionModal").modal("show");
		$("#deleteTranBtn").click(function () {
			$.ajax({
				url:"workbench/contacts/deleteTranById.do",
				data:{
					"id":id
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					if(data.success){
						showTranList();
						$("#removeTransactionModal").modal("hide");
					}else {
						$("#removeTransactionModal").modal("hide");
						alert("删除该条交易失败！")
					}
				}
			})
		})
	}
</script>

</head>
<body>

	<!-- 解除联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="unbundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">解除关联</h4>
				</div>
				<div class="modal-body">
					<p>您确定要解除该关联关系吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" id="unbundActivityBtn">解除</button>
				</div>
			</div>
		</div>
	</div>
	<!--删除交易窗口 -->
	<div class="modal fade" id="removeTransactionModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">删除交易</h4>
				</div>
				<div class="modal-body">
					<p>您确定要删除该交易吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" id="deleteTranBtn">删除</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="bundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">关联市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" style="width: 300px;" id="searchActivity" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable2" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input id="checkAll" type="checkbox"/></td>
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
					<button type="button" class="btn btn-primary" id="bundBtn">关联</button>
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
								<input type="text" class="form-control time2" id="edit-birth">
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
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time1" id="edit-nextContactTime">
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
	<!-- 修改联系人备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
		<div class="modal-dialog" role="document" style="width: 40%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" >修改备注</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">内容</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="noteContent"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3 id="title-name">${contacts.fullname}&nbsp;${contacts.appellation}<small>${contacts.customerId}&nbsp;</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteContacts"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<input id="detail-id" type="hidden" value="${contacts.id}">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-owner">${contacts.owner} &nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-source">${contacts.source} &nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;" id="detail-customerName"><b>${contacts.customerId}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-fullname">${contacts.fullname}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">邮箱</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-email">${contacts.email}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-mphone">${contacts.mphone}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">职位</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-job">${contacts.job}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-birth">&nbsp${contacts.birth}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="detail-createBy">${contacts.createBy}&nbsp;&nbsp;&nbsp;</b><small id="detail-createTime" style="font-size: 10px; color: gray;">${contacts.createTime}&nbsp;</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="detail-editBy">${contacts.editBy}&nbsp;&nbsp;&nbsp;</b><small id="detail-editTime" style="font-size: 10px; color: gray;">${contacts.editTime}&nbsp;</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="detail-description">
					${contacts.description}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="detail-contactSummary">
					&nbsp;${contacts.contactSummary}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-nextContactTime">&nbsp;${contacts.nextContactTime}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 90px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b id="detail-address">
					${contacts.address}&nbsp;
                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	<!-- 备注 -->
	<div id="remarkBody" style="position: relative; top: 20px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveRemarkBtn">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 交易 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>交易</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable3" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>金额</td>
							<td>阶段</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>类型</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tranBody">
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="workbench/transaction/add.do" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
			</div>
		</div>
	</div>
	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>市场活动</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>开始日期</td>
							<td>结束日期</td>
							<td>所有者</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="activityBody">
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="javascript:void(0);" data-toggle="modal" data-target="#bundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
			</div>
		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
</html>