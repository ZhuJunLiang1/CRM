<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <script src="ECharts/echarts.min.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }
        .main{
            width: 100%;
            height: 100%;
            position: absolute;
        }
        .partOfMain {
            width: 50%;
            height: 50%;
            float: left;
        }
    </style>
    <script>
        $(function () {
            //页面加载完毕后，绘制统计图表
            getCharts();
        })
        function getCharts() {
            $.ajax({
                url:"workbench/clue/getCharts.do",
                type:"get",
                dataType:"json",
                success:function (data) {
                    // 基于准备好的dom，初始化echarts实例
                    var myFunnel = echarts.init(document.getElementById('funnel'));
                    var myPie = echarts.init(document.getElementById('pie'));
                    var myLine = echarts.init(document.getElementById('line'));
                    var myBar = echarts.init(document.getElementById('bar'));
                    // 指定图表的配置项和数据
                    funnelOption = {
                        title: {
                            text: '线索来源漏斗图',
                            subtext: '线索来源漏斗图'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c}%"
                        },
                        series: [
                            {
                                name:'线索数量',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 60,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: data.dataList
                            }
                        ]
                    };//四分图   饼图，折线，柱状， 漏斗图
                    pieoption = {
                        backgroundColor: '#FFF',

                        title: {
                            text: '线索来源饼状图',
                            left: 'center',
                            top: 20,
                            textStyle: {
                                color: '#000'
                            }
                        },

                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                        },

                        visualMap: {
                            show: false,
                            min: 0,
                            max: data.total,
                            inRange: {
                                colorLightness: [0, 1]
                            }
                        },
                        series: [
                            {
                                name: '线索数量',
                                type: 'pie',
                                radius: '55%',
                                center: ['50%', '50%'],
                                data: data.dataList.sort(function (a, b) { return a.value - b.value; }),
                                roseType: 'radius',
                                label: {
                                    color: 'rgba(255, 255, 255, 0.3)'
                                },
                                labelLine: {
                                    lineStyle: {
                                        color: 'rgba(255, 255, 255, 0.3)'
                                    },
                                    smooth: 0.2,
                                    length: 10,
                                    length2: 20
                                },
                                itemStyle: {
                                    color: '#c23531',
                                    shadowBlur: 200,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                },

                                animationType: 'scale',
                                animationEasing: 'elasticOut',
                                animationDelay: function (idx) {
                                    return Math.random() * 200;
                                }
                            }
                        ]
                    };
                    lineoption = {
                        xAxis: {
                            type: 'category',
                            data: data.clueList
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: data.countList,
                            type: 'line'
                        }]
                    };
                    baroption = {
                        xAxis: {
                            type: 'category',
                            data: data.clueList
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: data.countList,
                            type: 'bar'
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myFunnel.setOption(funnelOption);
                    myPie.setOption(pieoption);
                    myLine.setOption(lineoption);
                    myBar.setOption(baroption);
                }
            })
        }
    </script>
</head>
<body>
<div id="main" class="main">
    <div id="pie" class="partOfMain pie"></div>
    <div id="line" class="partOfMain line"></div>
    <div id="bar" class="partOfMain bar"></div>
    <div id="funnel" class="partOfMain funnel"></div>
</div>
</body>
</html>