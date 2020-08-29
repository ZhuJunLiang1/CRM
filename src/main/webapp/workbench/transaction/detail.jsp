<%@ page import="com.zjl.crm.settings.domain.DicValue" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.zjl.crm.workbench.domain.Tran" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" +
			request.getServerName() + ":" +
			request.getServerPort() +
			request.getContextPath() + "/";
	//准备字典类型为stage的字典值列表
	List<DicValue> dicValueList = (List<DicValue>) application.getAttribute("stage");
	//准备阶段和可能性之间的对应关系
	Map<String, String> pMap = (Map<String, String>) application.getAttribute("pMap");
	//根据pMap准备pMap中的key集合
	Set<String> set = pMap.keySet();
	//准备前面正常阶段和后面丢失阶段的分界点下标
	int point = 0;
	for (int i = 0; i<dicValueList.size(); i++){
		//取得每一个字典值
		DicValue dicValue = dicValueList.get(i);
		String stage = dicValue.getValue();
		//取得可能性
		String possibility = pMap.get(stage);
		//分界点
		if("0".equals(possibility)){
			point = i;
			break;
		}
	}

%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
	
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
		
		
		//阶段提示框
		$(".mystage").popover({
            trigger:'manual',
            placement : 'bottom',
            html: 'true',
            animation: false
        }).on("mouseenter", function () {
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide")
                        }
                    }, 100);
                });
		showHistoryList();
		showRemarkList();
		//添加备注
		$("#saveRemarkBtn").click(function () {
			$.ajax({
				url:"workbench/transaction/saveRemark.do",
				data:{
					"noteContent":$.trim($("#remark").val()),
					"tranId": "${tran.id}",
				},
				type:"post",
				dataType:"json",
				success:function (data) {
					if(data.success){
						var html = "";
						html += '<div id="'+data.tranRemark.id+'" class="remarkDiv" style="height: 60px;">';
						html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
						html += '<div style="position: relative; top: -40px; left: 40px;" >';
						html += '<h5 id="e'+data.tranRemark.id+'">'+ data.tranRemark.noteContent+'</h5>';
						html += '<font color="gray">交易</font> <font color="gray">-</font> <b>${tran.name}</b> <small style="color: gray;" id="s'+data.tranRemark.id+'" > '+(data.tranRemark.createTime)+' 由'+(data.tranRemark.createBy+'创建')+'</small>';
						html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
						html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+data.tranRemark.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '&nbsp;&nbsp;&nbsp;&nbsp;';
						html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.tranRemark.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
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
				url:"workbench/transaction/updateRemark.do",
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
						$("#e"+id).html(data.tranRemark.noteContent);
						$("#s"+id).html(data.tranRemark.editTime + "由"+ data.tranRemark.editBy+"修改");
						$("#editRemarkModal").modal("hide");
					}else {
						alert("修改备注失败！");
					}
				}
			})
		})
		$("#deleteTanBtn").click(function () {
			if(confirm("确定删除该交易么？")){
				$.ajax({
					url:"workbench/transaction/delete.do",
					data:{
						"id":"${tran.id}"
					},
					type:"post",
					dataType:"json",
					success:function (data) {
						if(data.success){
							window.location.href="workbench/transaction/index.jsp";
						}
					}
				})
			}
		})
	});
	function showHistoryList() {
		$.ajax({
			url:"workbench/transaction/getHistoryListByTranId.do",
			data:{
				"tranId" : "${tran.id}"
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				var html = "";
				$.each(data,function (i,n) {
					html += '<tr>';
					html += '<td>'+n.stage+'</td>';
					html += '<td>'+n.money+'</td>';
					html += '<td>'+n.possibility+'</td>';
					html += '<td>'+n.expectedDate+'</td>';
					html += '<td>'+n.createTime+'</td>';
					html += '<td>'+n.createBy+'</td>';
					html += '</tr>';
				})
				$("#tranHistoryBody").html(html);
			}
		})
	}
	function editRemark(id) {
		$("#remarkId").val(id);
		var noteContent = $("#e"+id).html();
		//将展现出来的信息，赋予到修改操作模态窗口
		$("#noteContent").val(noteContent);
		$("#editRemarkModal").modal("show");
	}
	function showRemarkList() {
		$.ajax({
			url:"workbench/transaction/getRemarkListByTranId.do",
			data:{
				"tranId":"${tran.id}"
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
					html += '<font color="gray">交易</font> <font color="gray">-</font> <b>${tran.name}</b> <small style="color: gray;" id="s'+n.id+'"> '+(n.editFlag == 0? n.createTime:n.editTime)+' 由'+(n.editFlag == 0? n.createBy+'创建':n.editBy+'修改')+'</small>';
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
			url:"workbench/transaction/deleteTranRemarkById.do",
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
	//改变交易阶段
        // 参数 stage 需要改变的阶段， i 需要改变阶段对应的下标
	function changeStage(stage,i) {
		$.ajax({
			url:"workbench/transaction/changeStage.do",
			data:{
				"id" : "${tran.id}",
				"stage" : stage,
				"money" : "${tran.money}",
				"expectedDate" : "${tran.expectedDate}"
			},
			type:"post",
			dataType:"json",
			success:function (data) {
				/*
					success ： trur/false  ”tran“：tran对象

				 */
				if(data.success){
					//成功后 局部刷新 可能性 修改人，阶段 ，修改时间

					$("#stage").html(data.tran.stage);
					$("#possibility").html(data.tran.possibility);
					$("#editBy").html(data.tran.editBy);
					$("#editTime").html(data.tran.editTime);

					//改变阶段成功后 动态改变阶段图标，重新赋予样式及颜色
					changeIcon(stage,i);
					showHistoryList();
				}else {
					alert("改变阶段失败！");
				}
			}
		})
    }
    function changeIcon(stage,i) {
		var currentStage = stage;
		//可能性
		var currentPossibility = $("#possibility").html();
		//当前阶段的下标
		var index = i;
		//正常阶段和丢失阶段的分界点下标
		var point = "<%=point%>";
		//若当前阶段可能性为0 前七个为黑圈 后俩一个红 一个黑
		if ("0"==currentPossibility){
			//遍历前7个
			for (var i=0;i<point;i++){
				//黑圈-----------
				$("#"+i).removeClass();
				//添加新样式
				$("#"+i).addClass("glyphicon glyphicon-record mystage");
				//为新样式赋予颜色
				$("#"+i).css("color","#000000");
			}
			//后俩 一个红一个黑
			for (var i=point;i<<%=dicValueList.size()%>;i++){
				if(i==index){//当前阶段  红
					$("#"+i).removeClass();
					//添加新样式
					$("#"+i).addClass("glyphicon glyphicon-remove mystage");
					//为新样式赋予颜色
					$("#"+i).css("color","#FF0000");
				}else {//非当前阶段 黑
					$("#"+i).removeClass();
					//添加新样式
					$("#"+i).addClass("glyphicon glyphicon-remove mystage");
					//为新样式赋予颜色
					$("#"+i).css("color","#000000");
				}
			}


		}else {//若当前阶段可能性不为0 前七个 绿圈 绿标 黑圈 后两个黑叉
			//遍历前7个
			for (var i=0;i<point;i++){
				if(i==index){//当前阶段  绿标
					$("#"+i).removeClass();
					//添加新样式
					$("#"+i).addClass("glyphicon glyphicon-map-marker mystage");
					//为新样式赋予颜色
					$("#"+i).css("color","#90F790");
				}else if(i<index){ //小于 绿圈
					$("#"+i).removeClass();
					//添加新样式
					$("#"+i).addClass("glyphicon glyphicon-ok-circle mystage");
					//为新样式赋予颜色
					$("#"+i).css("color","#90F790");
				}else {	//黑圈
					$("#"+i).removeClass();
					//添加新样式
					$("#"+i).addClass("glyphicon glyphicon-record mystage");
					//为新样式赋予颜色
					$("#"+i).css("color","#000000");
				}
			}
			for (var i=point;i<<%=dicValueList.size()%>;i++){
				//黑叉
				$("#"+i).removeClass();
				//添加新样式
				$("#"+i).addClass("glyphicon glyphicon-remove mystage");
				//为新样式赋予颜色
				$("#"+i).css("color","#000000");
			}
		}

	}
</script>

</head>
<body>
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
						<label for="noteContent" class="col-sm-2 control-label">内容</label>
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
			<h3 id="title">${tran.customerId}-${tran.name} <small>￥${tran.money}&nbsp;</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" onclick="window.location.href='workbench/transaction/edit.do?id='+'${tran.id}'"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteTanBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>

	<!-- 阶段状态 -->
	<div style="position: relative; left: 40px; top: -50px;">
		阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
			//准备当前阶段
			Tran tran = (Tran) request.getAttribute("tran");
			String currentStage = tran.getStage();
			String currentPossibility = pMap.get(currentStage);
			//判断当前阶段 若可能性为0 前7个必为黑圈 后两个其中之一为红
			if("0".equals(currentPossibility)){
			    for(int i = 0; i< dicValueList.size();i++){
			        //取出每一个遍历出来的阶段，取得其可能性
                    DicValue dv = dicValueList.get(i);
                    String listStage = dv.getValue();
                    String listPossibility = pMap.get(listStage);
                    //若阶段的可能性为0则为后两个 前七个一定为黑圈 判断哪个为红
                    if("0".equals(listPossibility)){
                        if(listStage.equals(currentStage)){
                            //该 阶段为红叉
                        %>
        <span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')" class="glyphicon glyphicon-remove mystage"
              data-toggle="popover" data-placement="bottom"
              data-content="<%=dv.getText()%>" style="color: #FF0000;"></span>
		            -------------
                                <%
                                }else {
                                    //为黑叉
                                %>
        <span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
              class="glyphicon glyphicon-remove mystage"
              data-toggle="popover" data-placement="bottom"
              data-content="<%=dv.getText()%>" style="color: #000000;"></span>
        -------------
                                <%
                                }
                            }else {
                                %>
        <span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
              class="glyphicon glyphicon-record mystage"
              data-toggle="popover" data-placement="bottom"
              data-content="<%=dv.getText()%>" style="color: #000000;"></span>
        -------------
        <%
                            }
                        }
                    //若不为0则前七个可能是绿圈，绿色交易
                    }else {
                        //当阶段下标
                        int index=0;
                        for (int i =0;i<dicValueList.size();i++){
                            DicValue dv = dicValueList.get(i);
                            String stage = dv.getValue();
                            //String possibility = pMap.get(stage);
                            if(stage.equals(currentStage)){
                                index = i;
                                break;
                            }
                        }
                        for(int i = 0; i< dicValueList.size();i++) {
                            //取出每一个遍历出来的阶段，取得其可能性
                            DicValue dv = dicValueList.get(i);
                            String listStage = dv.getValue();
                            String listPossibility = pMap.get(listStage);
                            if ("0".equals(listPossibility)){
        %>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #000000;"></span>
		-------------
		<%
                                //为0则为黑叉
                                //不为0是前七个阶段 绿圈或黑圈
                            }else {
                                //如果是当前阶段
                                if (i == index){
                                    //绿色标记
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-map-marker mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #90F790;"></span>
		-------------
		<%
                                } else if (i<index) {//如果小于当前阶段
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-ok-circle mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #90F790;"></span>
		-------------
		<%
                                    //绿圈
                                }else {//如果大于当前阶段
                                            //黑圈
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-record mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #000000;"></span>
		-------------
								<%

                                }
                            }
                        }

                    }
                %>
		<span class="closingDate">${tran.expectedDate}&nbsp;</span>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: 0px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<input type="hidden" name="detail-id" value="${tran.id}">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-owner">${tran.owner}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-money">${tran.money}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-customerIdAndName">${tran.customerId}-${tran.name} </b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="detail-expectedDate">${tran.expectedDate}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-customerId">${tran.customerId}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">${tran.stage}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">类型</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="detail-type">${tran.type}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibility">${tran.possibility}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.source}&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.activityId}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">联系人名称</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.contactsId}&nbsp;</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.createBy}&nbsp;&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${tran.createTime}&nbsp;</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy">${tran.editBy}&nbsp;&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="editTime">${tran.editTime}&nbsp;</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${tran.description}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					&nbsp;${tran.contactSummary}&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 100px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>&nbsp;${tran.nextContactTime}&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 100px; left: 40px;" id="remarkBody" >
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
	
	<!-- 阶段历史 -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>阶段历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>阶段</td>
							<td>金额</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>创建时间</td>
							<td>创建人</td>
						</tr>
					</thead>
					<tbody id="tranHistoryBody">
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<div style="height: 200px;"></div>
	
</body>
</html>