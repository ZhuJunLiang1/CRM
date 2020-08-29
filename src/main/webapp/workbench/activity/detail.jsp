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
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
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
        $("#cancelBtn").click(function(){
            //显示
            $("#cancelAndSaveBtn").hide();
            //设置remarkDiv的高度为130px
            $("#remarkDiv").css("height","90px");
            cancelAndSaveBtnDefault = true;
        });
	});
	$(function () {
		//为编辑按钮添加事件
		$("#edit_activity").click(function () {
			var id = $("#detail-id").val();
			$.ajax({
				url : "workbench/activity/getUserListAndActivity.do",
				data : {
					"id" : id
				},
				type : "get",
				dataType : "json",
				success : function (data) {
					var html = "";
					$.each(data.uList,function (i,n) {
						html += "<option value='" + n.id + "'>" + n.name + "</option>"
					})
					$("#edit-owner").html(html);
					$("#edit-owner").val(data.activity.owner);
					$("#editActivityModal").modal("show");
				}
			})
		})
		//为更新按钮设置事件
		$("#updateDetail").click(function () {
			var id = $("#detail-id").val();
			$.ajax({
				url : "workbench/activity/update.do",
				data :{
					"id" : id,
					"owner" : $.trim($("#edit-owner").val()),
					"name" : $.trim($("#edit-name").val()),
					"startDate" : $.trim($("#edit-startDate").val()),
					"endDate" : $.trim($("#edit-endDate").val()),
					"cost" : $.trim($("#edit-cost").val()),
					"description" : $.trim($("#edit-description").val())
				},
				type: "post",
				dataType : "json",
				success : function (data) {
					if(data.success){
						$.ajax({
							url : "workbench/activity/detail1.do?id="+id,
							type:"get",
							dataType:"json",
							success: function (data1) {
								$("#marketActivity").html("市场活动-" + data1.name + "<small>" + data1.startDate + "~" + data1.endDate + "</small>");
								$("#detail-owner").html(data1.owner);
								$("#detail-name").html(data1.name);
								$("#detail-startDate").html(data1.startDate);
								$("#detail-endDate").html(data1.endDate);
								$("#detail-cost").html(data1.cost);
								$("#detail-create").html("<b>"+ data1.createBy + "&nbsp;&nbsp;</b><small style=\"font-size: 10px; color: gray;\">" + data1.createTime+"</small>");
								$("#detail-edit").html("<b>" + data1.editBy + "&nbsp;&nbsp;</b><small style=\"font-size: 10px; color: gray;\">" + data1.editTime + "</small>");
								$("#detail-description").html(data1.description);
							}
						})
						$("#editActivityModal").modal("hide");
					}else {
						alert("修改市场活动失败");
					}
				}
			})
		})

	//页面加载完毕后，展现该市场活动关联的备注信息列表。
		showRemarkList();
		//添加备注
        $("#saveRemarkBtn").click(function () {
            $.ajax({
                url:"workbench/activity/saveRemark.do",
                data:{
                    "noteContent":$.trim($("#remark").val()),
                    "activityId": "${activity.id}",
                },
                type:"post",
                dataType:"json",
                success:function (data) {
                    //data   "activityRemark":属性
                    if(data.success){
                        //在文本域上方添加一个DIV
                        var html = "";
                        html += '<div id="'+data.activityRemark.id+'" class="remarkDiv" style="height: 60px;">';
                        html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                        html += '<div style="position: relative; top: -40px; left: 40px;" >';
                        html += '<h5 id="e'+data.activityRemark.id+'">'+ data.activityRemark.noteContent+'</h5>';
                        html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small style="color: gray;" id="s'+data.activityRemark.id+'" > '+(data.activityRemark.createTime)+' 由'+(data.activityRemark.createBy+'创建')+'</small>';
                        html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
                        html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+data.activityRemark.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
                        html += '&nbsp;&nbsp;&nbsp;&nbsp;';
                        html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.activityRemark.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
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
                url:"workbench/activity/updateRemark.do",
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
                        $("#e"+id).html(data.activityRemark.noteContent);
                        $("#s"+id).html(data.activityRemark.editTime + "由"+ data.activityRemark.editBy+"修改");
                        $("#editRemarkModal").modal("hide");
                    }else {
                        alert("修改备注失败！");
                    }
                }
            })
        })

        //详情页删除按钮绑定事件
        $("#delete_activity").click(function () {
            if(confirm("你确定要删除本条信息么")){
                $.ajax({
                    url:"workbench/activity/delete.do",
                    data:{
                        "id":$("#detail-id").val()
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if(data.success){
                            window.location.href="workbench/activity/index.jsp";
                        }
                    }

                })
            }
        })

	});
    //编辑备注
	function editRemark(id) {
	    $("#remarkId").val(id);
	    var noteContent = $("#e"+id).html();
	    //将展现出来的信息，赋予到修改操作模态窗口
        $("#noteContent").val(noteContent);
       $("#editRemarkModal").modal("show");
    }

	//局部刷新备注列表
	function showRemarkList() {
		$.ajax({
			url:"workbench/activity/getRemarkListById.do",
			data:{
				"activityId":"${activity.id}"
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
					html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small style="color: gray;" id="s'+n.id+'"> '+(n.editFlag == 0? n.createTime:n.editTime)+' 由'+(n.editFlag == 0? n.createBy+'创建':n.editBy+'修改')+'</small>';
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
	//删除备注
	function deleteRemark(id) {
        $.ajax({
            url:"workbench/activity/deleteRemark.do",
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
	
</script>

</head>
<body>
	
	<!-- 修改市场活动备注的模态窗口 -->
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

    <!-- 修改市场活动的模态窗口 -->
    <div class="modal fade" id="editActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-owner">
                                </select>
                            </div>
                            <label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name" value="${activity.name}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-startDate" class="col-sm-2 control-label">开始日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-startDate" value="${activity.startDate}">
                            </div>
                            <label for="edit-endDate" class="col-sm-2 control-label">结束日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-endDate" value="${activity.endDate}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-cost" value="${activity.cost}">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-description" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-description">${activity.description}</textarea>
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateDetail">更新</button>
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
			<input type="hidden" id="detail-id" value="${activity.id}">
			<h3 id="marketActivity">市场活动-${activity.name} <small>${activity.startDate} ~ ${activity.endDate}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" id="edit_activity"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="delete_activity"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-owner">${activity.owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-name">${activity.name}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-startDate">${activity.startDate}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-endDate">${activity.endDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-cost">${activity.cost}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;" id="detail-create"><b >${activity.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;" id="detail-edit"><b>${activity.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${activity.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="detail-description">
					${activity.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div id="remarkBody" style="position: relative; top: 30px; left: 40px;">
		<div class="page-header" >
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
	<div style="height: 200px;"></div>
</body>
</html>