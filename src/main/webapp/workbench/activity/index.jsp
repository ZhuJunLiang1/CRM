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
	    //为添加操作加事件
		$("#addBtn").click(function () {
			/*操作模态窗口的方式：
			操作模态窗口的jquery对象，调用modal方法 为该方法传参 show：打开 hide：关闭
			 */
			//$("#createActivityModal").modal("show");
			//走后台取得用户信息列表，所有者下拉框填填充数值
			$.ajax({
				url:"workbench/activity/getUserList.do",
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
					$("#createActivityModal").modal("show");
				}
			})
		})
        //为模态窗口的添加按钮加事件
		$("#saveBtn").click(function () {
			$.ajax({
				url:"workbench/activity/save.do",
				data: {
					"owner":$.trim($("#create-owner").val()),
					"name":$.trim($("#create-name").val()),
					"startDate":$.trim($("#create-startDate").val()),
					"endDate":$.trim($("#create-endDate").val()),
					"cost":$.trim($("#create-cost").val()),
					"description":$.trim($("#create-description").val())
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
                        pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

                        //清空添加操作模态窗口数据
						/*
							拿到了jquery对象，但是只有submit方法可用， reset方法无用
							JS原生DOM对象有 reset方法
							jquery转换DOM
								jquery对象【0】
							dom转换成jquery
								$(dom)为jquery
						 */
						$("#activityAddForm")[0].reset();
						//关闭添加操作模态窗口
						$("#createActivityModal").modal("hide");
					}else {
						alert("添加市场活动失败")
					}
				}
			})
		})
		//局部刷新出来活动列表
		/*
			什么时候需要获取局部刷新。
				点击市场活动
				保存完毕后
				修改完毕后
				删除完毕后
				查询后
				点击分页组件时
		 */
		pageList(1,10);

		//为查询按钮绑定事件，触发pageList方法
		$("#searchBtn").click(function () {
		    /*
		    点击查询按钮的时候，应该将搜索框中信息保存，
                使用隐藏域 保存。
		    */
            $("#hidden-name").val($.trim($("#search-name ").val()));
            $("#hidden-owner").val($.trim($("#search-owner").val()));
            $("#hidden-startDate").val($.trim($("#search-startDate").val()));
            $("#hidden-endDate").val($.trim($("#search-endDate").val()));
            //回到第一页，维持当前每页数据
            pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));

        })


        //为全选复选框绑定事件，触发全选操作
        $("#checkAll").click(function () {
            $("input[name=check]").prop("checked",this.checked);
        })
        //动态生成的元素不能以普通绑定事件形式来进行操作。
        // $("input[name=check]").click(function () {
        //
        // })

        //动态生成的元素以 on 方法触发事件
        //语法：$(需要绑定的元素的有效的外层元素).on(事件，jquery对象，函数)
        $("#activityBody").on("click",$("input[name=check]"),function () {
            $("#checkAll").prop("checked",$("input[name=check]").length==$("input[name=check]:checked").length);
        })

        //删除按钮绑定事件，执行市场活动的删除操作
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
                        url:"workbench/activity/delete.do",
                        data:param,
                        type:"post",
                        dataType:"json",
                        success:function (data) {
                            if(data.success){
                                //回到第一页，维持 每页展现记录数
                                pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else {
                                alert("删除市场活动失败");
                            }
                        }
                    })
                }
            }
        })

        //为修改按钮绑定事件： ，打开修改操作的模态窗口
        $("#editBtn").click(function () {
            var $check = $("input[name=check]:checked");
            if($check.length ==0 ){
                alert("请选择需要修改的记录");
            }else if($check.length > 1 ){
                alert("只能选择一条记录进行修改");
            }else {
                var id = $check.val();
                $.ajax({
                    url:"workbench/activity/getUserListAndActivity.do",
                    data:{
                      "id":id
                    },
                    type:"get",
                    dataType:"json",
                    success:function (data) {
                        /*
                        data： 用户列表  市场活动对象
                            {"uList":[{用户1},{用户二}]，"activity":{市场活动}}
                        */
                        var html = "<option></option>";
                        $.each(data.uList,function (i,n) {
                            html += "<option value='" + n.id + "'>" + n.name + "</option>"
                        })

                        $("#edit-owner").html(html);

                        //处理单条activity
                        $("#edit-id").val(data.activity.id);
                        $("#edit-name").val(data.activity.name);
                        $("#edit-owner").val(data.activity.owner);
                        $("#edit-startDate").val(data.activity.startDate);
                        $("#edit-endDate").val(data.activity.endDate);
                        $("#edit-cost").val(data.activity.cost);
                        $("#edit-description").val(data.activity.description);
                        $("#editActivityModal").modal("show");
                    }
                })
            }
        })

        //为更新按钮绑定事件，执行市场活动的修改操作
        $("#updateBtn").click(function () {
            $.ajax({
                url:"workbench/activity/update.do",
                data: {
                    "id" : $.trim($("#edit-id").val()),
                    "owner" : $.trim($("#edit-owner").val()),
                    "name" : $.trim($("#edit-name").val()),
                    "startDate" : $.trim($("#edit-startDate").val()),
                    "endDate" : $.trim($("#edit-endDate").val()),
                    "cost" : $.trim($("#edit-cost").val()),
                    "description" : $.trim($("#edit-description").val())
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
                        pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                            ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                        //关闭添加操作模态窗口
                        $("#editActivityModal").modal("hide");
                    }else {
                        alert("修改市场活动失败")
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
        $("#search-startDate").val($.trim($("#hidden-startDate").val()));
        $("#search-endDate").val($.trim($("#hidden-endDate").val()));
		$.ajax({
			url:"workbench/activity/pageList.do",
			data:{
				"pageNo":pageNo,
				"pageSize":pageSize,
				"name":$.trim($("#search-name").val()),
				"owner":$.trim($("#search-owner").val()),
				"startDate":$.trim($("#search-startDate").val()),
				"endDate":$.trim($("#search-endDate").val())
			},
			type:"get",
			dataType:"json",
			success:function (data) {
				/*
					市场活动信息列表
					分页插件需要的 ，查询出来的总记录数
					{“total”：100,"dataList":[{市场活动1}，]}
				 */
				var html = "";
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="check" value="'+n.id+'" /></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.do?id='+n.id+'\';">'+n.name+'</a></td>';
                	html += '<td>'+n.owner+'</td>';
					html += '<td>'+n.startDate+'</td>';
					html += '<td>'+n.endDate+'</td>';
					html += '</tr>';
				})
                 $("#activityBody").html(html);
				//计算总页数
                var totalPages = data.total%pageSize == 0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;

				//数据处理完毕后，结合分页插件，
                $("#activityPage").bs_pagination({
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
<input type="hidden" id="hidden-startDate">
<input type="hidden" id="hidden-endDate">
<!-- 创建市场活动的模态窗口 -->
    <div class="modal fade" id="createActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
                </div>

                <div class="modal-body">

                    <form class="form-horizontal" role="form" id="activityAddForm">

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
                        <label for="create-startDate" class="col-sm-2 control-label ">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-startDate" readonly>
                        </div>
                        <label for="create-endDate" class="col-sm-2 control-label time">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="create-endDate" readonly>
                        </div>
                    </div>
                        <div class="form-group">
                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-description" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="create-description"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <!--data-dismiss:关闭模态窗口 -->
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
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
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
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
                        <label for="edit-startDate" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-startDate" >
                        </div>
                        <label for="edit-endDate" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control time" id="edit-endDate">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-description" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <!-- 关于文本域 textarea  一定要以标签对的形式来呈现 正常情况下要紧紧挨着
                                textarea 虽然以标签对形式来呈现的，但是它也是属于表单元素范畴，
                                我们所有的对于textarea的取指和赋值操作应统一使用val（）方法


                             -->
                            <textarea class="form-control" rows="3" id="edit-description"></textarea>
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
            <h3>市场活动列表</h3>
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
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control time" type="text" id="search-startDate" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon ">结束日期</div>
                        <input class="form-control time" type="text" id="search-endDate">
                    </div>
                </div>
                <button type="button" id="searchBtn" class="btn btn-default" >查询</button>
            </form>
        </div>
        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <!-- 点击创建按钮，观察属性和属性值
                     data-toggle=modal
                           表示触发该按钮，将要打开一个模态窗口
                       data-target=“#xxx”
                           要打开哪个模态窗口
                       现在是以属性和属性值的方式写在了button元素中，用来打开模态装口
                       但是这样做有问题：
                           没有办法对按钮的功能进行拓展

                       所以未来实际项目中，对于触发模态窗口的操作，一定不要写死在元素中，
                       由自己写js代码来操作
                                  -->
                <button type="button" class="btn btn-primary" id="addBtn"  ><span class="glyphicon glyphicon-plus"></span> 创建</button>
                <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
                <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="checkAll"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="activityBody">
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage">
                </div>
			</div>
			
		</div>
		
	</div>
</body>
</html>