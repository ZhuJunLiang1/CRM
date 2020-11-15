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
    <meta charset="UTF-8">
    <base href="<%=basePath%>">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


    <link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
    <script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
    <script type="text/javascript">
        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        $(function(){

            $("#notice").focus(function(){
                if(cancelAndSaveBtnDefault){
                    $("#noticeDiv").css("height","130px");
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function(){
                $("#cancelAndSaveBtn").hide();
                $("#noticeDiv").css("height","90px");
                cancelAndSaveBtnDefault = true;
            });

            $(".noticeDiv").mouseover(function(){
                $(this).children("div").children("div").show();
            });

            $(".noticeDiv").mouseout(function(){
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
                $("#noticeDiv").css("height","90px");
                cancelAndSaveBtnDefault = true;
            });
            pageList(1,10);

            //添加备注
            $("#saveNoticeBtn").click(function () {
                $.ajax({
                    url:"workbench/notice/saveNotice.do",
                    data:{
                        "noteContent":$.trim($("#notice").val())
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        //data   "activityRemark":属性
                        if(data.success){
                            location.reload();
                            $("#notice").val("");
                            alert("发布动态成功！");
                        }else {
                            alert("发布动态失败！");
                        }
                    }
                })
            })
        });


        //局部刷新备注列表
        function pageList(pageNo,pageSize) {
            $.ajax({
                url:"workbench/notice/pageList.do",
                data: {
                  "pageNo":pageNo,
                  "pageSize": pageSize
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    $("#noticeDiv").before("");
                    var html = "";
                    $.each(data.dataList,function (i,n) {
                        /*
                            javascript:void(0);
                                将超链接禁用，只能以触发事件的形式来操作
                         */
                        html += '<div id="'+n.id+'" class="noticeDiv" style="height: 60px;width: 900px; margin: 20px auto">';
                        html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
                        html += '<div style="position: relative; top: -40px; left: 40px;" >';
                        html += '<h4 id="e'+n.id+'">'+ n.noteContent+'</h4>';
                        html += ' <b style="color: gray;float: right" id="s'+n.id+'"> '+n.createTime+' 由'+n.createBy+'发布'+'</b>';
                        html += '<div style="position: relative; left: 870px; top: -50px; height: 30px; width: 100px; display: none;">';
                        html += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
                        html += '<a class="myHref"  href="javascript:void(0);" onclick="deleteNotice(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
                        html += '</div>';
                        html += '</div>';
                        html += '</div>';
                    })
                    $("#noticeBody").html(html);

                    $("#noticeBody").on("mouseover",".noticeDiv",function(){
                        $(this).children("div").children("div").show();
                    })
                    $("#noticeBody").on("mouseout",".noticeDiv",function(){
                        $(this).children("div").children("div").hide();
                    })
                    //计算总页数
                    var totalPages = data.total%pageSize == 0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;
                    //数据处理完毕后，结合分页插件
                    $("#noticePage").bs_pagination({
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

        function deleteNotice(id) {
            $.ajax({
                url:"workbench/notice/delete.do",
                data: {
                    "id" : id
                },
                type:"post",
                dataType:"json",
                success : function (data) {
                    if (data.success){
                        $("#"+id).remove();
                        pageList(1,10);
                        alert("删除动态成功");
                    }else {
                        alert("删除动态失败！")
                    }
                }
            })
        }
    </script>
</head>
<body style="width: 100%">
<h1 align="center">公司动态</h1>
    <div id="noticeBody" style="position: relative;margin: 0 auto">
    </div>
    <div id="noticeDiv" style="background-color: #E6E6E6; margin: 0 auto; width: 900px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="notice" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加动态..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" class="btn btn-primary" id="saveNoticeBtn">保存</button>
            </p>
        </form>
    </div>

    <div style="height: 50px; position: relative;top: 30px;">
        <div id="noticePage">
        </div>
    </div>
</div>
</body>
</html>