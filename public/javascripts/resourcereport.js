$(function () {

    $.jqplot.config.enablePlugins = true;
    $.jqplot.eventListenerHooks.push(['jqplotClick', myClickHandler]);
    function myClickHandler(ev, gridpos, datapos, neighbor, plot) {
        if (plot.targetId == '#chart-5')
        {
            var intvalue = parseInt(datapos.yaxis);
            var yaxis = datapos.yaxis;
            if (yaxis > (intvalue + 0.5) )
                yaxis += 1;
            intvalue = parseInt(yaxis);
            var label = plot.axes.yaxis.ticks[intvalue-1];
            window.location = "/materials/1/" + label.toString();
        }
    }
    function generateArray(str) {
        if (str != null && str != "") {
            var split = str.split('#');
            var array = new Array(split.length);
            for (var i = 0; i < split.length; i++) {
                split[i] = $.trim(split[i]);
                if(split[i] != null && split[i] != "")
                {
                    array[i] = new Array(2);
                    var split2 = split[i].split(",");
                    if (split2.length > 1) {
                        array[i][0] = $.trim(split2[0]);
                        array[i][1] = parseFloat($.trim(split2[1]),2);
                    }
                    else {
                        array[i][0] = 0;
                        array[i][1] = 0;
                    }
                }
            }
            return array;
        }
        else
        {
            var array = new Array(1);
            array[0] = new Array(2);
            array[0][0] = 0;
            array[0][1] = 0;
            return array;
        }
    };
        //setTimeout(function() {
            $('#asphalt').bulletgraph('html',{type:'bullet',width:'350px',height:'50px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']},{noOfTicks:'5',minValue:'0',maxValue:'100',valueSymbol:'%'});
            $('#concrete').bulletgraph('html',{type:'bullet',width:'350px',height:'50px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']},{noOfTicks:'5',minValue:'0',maxValue:'100',valueSymbol:'%'});
            $('#hsteel').bulletgraph('html',{type:'bullet',width:'350px',height:'50px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']},{noOfTicks:'5',minValue:'0',maxValue:'100',valueSymbol:'%'});
            $('#rsteel').bulletgraph('html',{type:'bullet',width:'350px',height:'50px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']},{noOfTicks:'5',minValue:'0',maxValue:'100',valueSymbol:'%'});
            $('#machine').bulletgraph('html',{type:'bullet',width:'350px',height:'50px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']},{noOfTicks:'5',minValue:'0',maxValue:'100',valueSymbol:'%'});
            $('#hr').bulletgraph('html',{type:'bullet',width:'350px',height:'50px',performanceColor:'#006CC6',targetColor:'#FF2300', rangeColors:['#ddd','#bbb','#aaa']},{noOfTicks:'5',minValue:'0',maxValue:'100',valueSymbol:'%'});
        //},1000);

    //var s9 = [['External',70],['Internal',30]];
    //var s10= [['External',30],['Internal',70]];
    var s9 = generateArray($('#issuelastmonth').html());  // Last month External & Internal Issues
    var s10= generateArray($('#issuelastbeforemonth').html()); // Last before month External & Internal Issues    
    var s10a = generateArray($('#issuelast2monthsback').html()); // Last 2 months back External & Internal Issues

    //var s11 = [[23.06,1],[75.83,2],[27.14,3],[15.84,4],[8.39,5]];
    var s11 = generateArray($('#assetEfficiency').html());
    //var s12 = [[62.07,1],[62.93,2],[29.29,3],[76.44,4],[0.0,5]];
    var s12 = generateArray($('#productionEfficiency').html());

    
    var s13 = ['Batching Plant','Crusher Metso','HotMix Plant','Wet Plant','Kerb Laying'];
    var dotitle = 'Outermost ' + $('#donuttitle_outer_most').html() + ' , Outer ' + $('#donuttitle_outer').html() + ' , Inner ' + $('#donuttitle_inner').html();
    var bartitle='Efficiency for the Month of '+ $('#donuttitle_outer').html();
    var plot4 = $.jqplot('chart-4',[s9,s10,s10a],{
        title: dotitle,
        grid:{
            borderWidth:0,
            shadow: false,
            backgroundColor:'#FFFFFF'
        },
        axesDefaults:{
            pad: 1.5,
            rendererOptions:{
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                labelOptions:{
                    enableFontSupport: true,
                    fontFamily: 'Frutiger, "Frutiger Linotype", Univers, Calibri, "Gill Sans", "Gill Sans MT", "Myriad Pro", Myriad, "DejaVu Sans Condensed", "Liberation Sans", "Nimbus Sans L", Tahoma, Geneva, "Helvetica Neue", Helvetica, Arial, sans-serif',
                    fontSize: '0.9em'
                }
            }
        },
        seriesDefaults: {
            renderer:$.jqplot.DonutRenderer,
            shadow: false,
            rendererOptions: {
                highlightMouseOver:false
            }
        },
        seriesColors: ["#FF9000","#006CC6"],
        series:[
                {rendererOptions: {startAngle: -90, sliceMargin:0,ringMargin:2}},
                {rendererOptions: {startAngle: -90,sliceMargin:0, ringMargin:2}},
                {rendererOptions: {startAngle: -90,sliceMargin:0, ringMargin:2}}
            ],
        legend: {
            renderer: $.jqplot.EnhancedLegendRenderer,
            show: true,
            showSwatches: true,
            rendererOptions: {
                numberRows: 1
            },
            placement: 'outside',
            location: 's',
            marginTop: '30px'
                },
        cursor:{show:false}
    });
    plot5 = $.jqplot('chart-5',[s11,s12],{
        grid:{
            borderWidth:0,
            shadow: false,
            backgroundColor: '#FFFFFF'
        },
        highlighter:{
            show:false
        },
        stackSeries: false,
        seriesColors: ["#006CC6","#FF9000"],
        legend:{
            renderer: $.jqplot.EnhancedLegendRenderer,
            show: true,
            showSwatches: true,
            rendererOptions: {
                numberRows: 1
            },
            placement: 'outside',
            location: 's',
            marginTop: '40px'
        },
        title:bartitle,
        axesDefaults:{
            pad: 1.5,
            rendererOptions:{
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                labelOptions:{
                    enableFontSupport: true,
                    fontFamily: 'Frutiger, "Frutiger Linotype", Univers, Calibri, "Gill Sans", "Gill Sans MT", "Myriad Pro", Myriad, "DejaVu Sans Condensed", "Liberation Sans", "Nimbus Sans L", Tahoma, Geneva, "Helvetica Neue", Helvetica, Arial, sans-serif',
                    fontSize: '0.9em'
                }
            }
        },
        seriesDefaults:{
            renderer: $.jqplot.BarRenderer,
            pointLabels:{
                show:true,
                hideZeros: false,
                xpadding: 5,
                formatString:'%s %'
            },
            rendererOptions:{
                highlightMouseOver:true,
                barDirection:'horizontal',
                barPadding:2,
                barMargin:5,
                shadow:false
            }
        },
        series:[{
           label: 'Asset Efficiency'
        },
        {
            label:'Production Efficiency'
        }],
        axes:{
            xaxis:{
                min: 0,
                max: 100,
                tickInterval:20,
                tickOptions:{
                    showGridline: false,
                    showMark: false,
                    formatString:'%.0f %'
                }
            },
            yaxis:{
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: s13,
                tickOptions:{
                    showGridline: true,
                    showMarker: false
                }
            }
        },
        cursor:{
            show:true,
            style:'pointer',
            showTooltip:false,
            zoom:false
        }
    });
});