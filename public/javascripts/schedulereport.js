$(function () {

    $.jqplot.config.enablePlugins = true;


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




/**    s1 = [['2010-Apr-1', -3], ['2010-May-1', -1], ['2010-Jun-1', 1],['2010-Jul-1', 2],['2010-Aug-1', 4]];
    s2 = [['2010-Apr-1', -2], ['2010-May-1', 0], ['2010-Jun-1', 3],['2010-Jul-1', 4],['2010-Aug-1', 6]];
/**    s4 = [['2010-Apr-1', 236.7], ['2010-May-1', 262.42], ['2010-Jun-1', 286.83], ['2010-Jul-1', 303.03], ['2010-Aug-1', 318.56], ['2010-Sep-1', 383.56], ['2010-Oct-1', 409.29]];
    s5 = [['2010-Apr-1', 236.7], ['2010-May-1', 262.42], ['2010-Jun-1', 286.83], ['2010-Jul-1', 303.03], ['2010-Aug-1', 318.56], ['2010-Sep-1', 318.56], ['2010-Oct-1', 344.2983913], ['2010-Nov-1', 366.3378233], ['2010-Dec-1', 390.8902001], ['2011-Jan-1', 421.0881992],['2011-Feb-1', 441.4413344]];
    s6 = [['2010-Apr-1', 236.7], ['2010-May-1', 262.42], ['2010-Jun-1', 286.83], ['2010-Jul-1', 303.03], ['2010-Aug-1', 318.56], ['2010-Sep-1', 276.0], ['2010-Oct-1', 301.7383913], ['2010-Nov-1', 323.7778233], ['2010-Dec-1', 348.3301001], ['2011-Jan-1', 378.5281992],['2011-Feb-1', 398.8813344], ['2011-Mar-1', 441.4413344]];

    s4=[['2008-Jan-1',0.8],['2008-Feb-1',4.35],['2008-Mar-1',9.63],['2008-Apr-1',16.7],['2008-May-1',25.12],['2008-Jun-1',36.31],['2008-Jul-1',42.97],['2008-Aug-1',49.63],['2008-Sep-1',62.96],['2008-Oct-1',80.09],['2008-Nov-1',95.52],['2008-Dec-1',112.83],['2009-Jan-1',137.44],['2009-Feb-1',162.15],['2009-Mar-1',186.43],['2009-Apr-1',212.7],['2009-May-1',240.44],['2009-Jun-1',264.58],['2009-Jul-1',283.27],['2009-Aug-1',302.23],['2009-Sep-1',325.63],['2009-Oct-1',346.43],['2009-Nov-1',365.15],['2009-Dec-1',383.26],['2010-Jan-1',396.9],['2010-Feb-1',408.04],['2010-Mar-1',412]];
    s5=[['2008-Jan-1',0],['2008-Feb-1',0],['2008-Mar-1',0],['2008-Apr-1',0],['2008-May-1',0.7932446],['2008-Jun-1',1.58415209999431],['2008-Jul-1',3.70325261811882],['2008-Aug-1',6.34668152400494],['2008-Sep-1',7.99703209789767],['2008-Oct-1',10.8096321571569],['2008-Nov-1',13.8924201379789],['2008-Dec-1',15.8950381543046],['2009-Jan-1',24.2590852876044],['2009-Feb-1',30.2369826043764],['2009-Mar-1',41.7333328229845],['2009-Apr-1',52.2957031415845],['2009-May-1',61.8532144477167],['2009-Jun-1',71.5565972489377],['2009-Jul-1',82.1969223],['2009-Aug-1',94.7998192],['2009-Sep-1',107.1699039],['2009-Oct-1',118.76],['2009-Nov-1',124.23],['2009-Dec-1',137.44],['2010-Jan-1',160.63],['2010-Feb-1',185.5],['2010-Mar-1',210.93],['2010-Apr-1',236.7],['2010-May-1',262.42],['2010-Jun-1',286.83],['2010-Jul-1',303.03],['2010-Aug-1',318.65],['2010-Sep-1',342.18],['2010-Oct-1',365.91],['2010-Nov-1',389.34],['2010-Dec-1',412]];
    s6=[['2008-Jan-1',0],['2008-Feb-1',0],['2008-Mar-1',0],['2008-Apr-1',0],['2008-May-1',0.7932446],['2008-Jun-1',1.58415209999431],['2008-Jul-1',3.70325261811882],['2008-Aug-1',6.34668152400494],['2008-Sep-1',7.99703209789767],['2008-Oct-1',10.8096321571569],['2008-Nov-1',13.8924201379789],['2008-Dec-1',15.8950381543046],['2009-Jan-1',24.2590852876044],['2009-Feb-1',30.2369826043764],['2009-Mar-1',41.7333328229845],['2009-Apr-1',52.2957031415845],['2009-May-1',61.8532144477167],['2009-Jun-1',71.5565972489377],['2009-Jul-1',82.1969223],['2009-Aug-1',94.7998192],['2009-Sep-1',107.1699039],['2009-Oct-1',118.76],['2009-Nov-1',129.9885],['2009-Dec-1',149.7],['2010-Jan-1',170.8395],['2010-Feb-1',192.455],['2010-Mar-1',214.3595],['2010-Apr-1',236.2215],['2010-May-1',256.97],['2010-Jun-1',270.74],['2010-Jul-1',284.017],['2010-Aug-1',304.0175],['2010-Sep-1',324.188],['2010-Oct-1',344.1035],['2010-Nov-1',363.3645],['2010-Dec-1',378.7645],['2011-Jan-1',392.0045],['2011-Feb-1',404.0045],['2011-Mar-1',412.0045]];    s8 = [['2010-Apr-1', 0.49], ['2010-May-1', 0.52], ['2010-Jun-1', 0.56], ['2010-Jul-1', 0.61], ['2010-Aug-1', 0.65]];
    s7 = [['2010-Apr-1', 0.59], ['2010-May-1', 0.66], ['2010-Jun-1', 0.72], ['2010-Jul-1', 0.77], ['2010-Aug-1', 0.81]];
    s8 = [['2010-Apr-1', 0.49], ['2010-May-1', 0.52], ['2010-Jun-1', 0.56], ['2010-Jul-1', 0.61], ['2010-Aug-1', 0.65]];
    s9 = [['External',70],['Internal',30]];
    s10= [['External',30],['Internal',70]];
    s11 = [[23.06,1],[75.83,2],[22.09,3],[32.19,4],[15.84,5],[10.19,6],[8.25,7],[6.74,8]];
    s12 = [[62.07,1],[62.93,2],[0.0,3],[58.57,4],[76.44,5],[0.0,6],[0.0,7],[0.0,8]];
    s13 = ['Batching Plant CP30','Crusher Metso 320TPH','HotMix Plant 160TPH', 'HotMix Plant Lintec','Apollo Wet Plant','Apollo Kerb Laying KP40-2','Apollo Kerb Laying KP40-1','Apollo Kerb Laying KP40-3'];
**/

    var s1 = generateArray($('#contract_budget_confidence').html());  // Contract Confidence
    var s2 = generateArray($('#contract_reestimate_confidence').html());  // Contract re- estimate Confidence
    var s3 = [[]];
    var s4 = generateArray($('#pv_cummulative').html());  // PV Cummulative
    var s5 = generateArray($('#lresite_cummulative').html());  // LRE Site Cummulative
    var s6 = generateArray($('#lrepmc_cummulative').html());  // LRE PMC Cummulative
    var s7 = generateArray($('#cpi_cummulative').html());  // CPI Cummulative
    var s8 = generateArray($('#spi_cummulative').html());  // SPI Cummulative

    
        var minimumplot3 = parseInt($('#Lreminimum').html());
        var maximumplot3 = parseInt($('#Lremaximum').html());


        if (minimumplot3.toString().length > 1)
        {
            var output =  minimumplot3.toString().substr(0,2);
            for (var i=0; i < minimumplot3.toString().length - 2; i++)
            {
                output += "0";
            }
            minimumplot3 = parseFloat($.trim(output));
        }
        else
        {
            minimumplot3 = 0
        }
        if (maximumplot3.toString().length > 1)
        {
            var out =  maximumplot3.toString().substr(0,1) + (parseInt(maximumplot3.toString().substr(1,1)) + 1).toString();
            var zeros = '';
            for (var j=0; j < maximumplot3.toString().length - 2; j++)
            {
                zeros += "0";
            }
            maximumplot3 = parseFloat($.trim(out + zeros));
        }
        else
        {
            maximumplot3 = 9
        }



    var donuttitle = 'Outer circle ' + $('#donuttitle_outer').html() + ' , Inner circle ' + $('#donuttitle_inner').html();
    bartitle='Efficiency for the Month of '+ 'Aug-10';

    plot1 = $.jqplot('chart-1',[s1,s2],{
        grid:{
            borderWidth:0,
            shadow:false,
            backgroundColor: '#FFFFFF'
        },
        highlighter:{
            sizeAdjust: 2,
            tooltipLocation: 'n',
            bringSeriesToFront: true,
            formatString: '<table class="jqplot_highlighter"><tr><td>Month</td><td>: %s</td></tr><tr><td>Index</td><td>: %s</td></tr></table>',
            useAxesFormatters: true
        },
        axesDefaults:{
            pad: 1.5,
            rendererOptions:{
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                labelOptions:{
                    enableFontSupport: true,
                    fontFamily: 'Frutiger, "Frutiger Linotype", Univers, Calibri, "Gill Sans", "Gill Sans MT", "Myriad Pro", Myriad, "DejaVu Sans Condensed", "Liberation Sans", "Nimbus Sans L", Tahoma, Geneva, "Helvetica Neue", Helvetica, Arial, sans-serif',
                    fontSize: '0.9em'
                }
            }
        },
        axes: {
            xaxis:{
                renderer: $.jqplot.DateAxisRenderer,
                tickOptions: {
                    showMark: false,
                    formatString: '%b-%y',
                    showGridline: false
                }
            },
            yaxis:{
                min: -15,
                max: 15,
                tickOptions:{
                    formatString: '%.1f',
                    showGridline: true
                },
                label:'Current Efficiency / Required Efficiency'
            }
        },
        series:[
            { pointLabels:{show:false}, markerOptions: { style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
            { pointLabels:{show:false}, markerOptions: { style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
        ],
        seriesColors: ["#006CC6", "#FF9000"],
        legend: {
            renderer: $.jqplot.EnhancedLegendRenderer,
            show: true,
            showSwatches: true,
            labels: ['Budget', 'Re Estimate'],
            rendererOptions: {
                numberRows: 1
            },
            placement: 'outside',
            location: 's',
            marginTop: '40px',
            seriesToggle: true
        },
        cursor:{
            show:true,
            zoom:true,
            showTooltip:false
        }
    });
    plot2 = $.jqplot('chart-2',[s4,s5,s6],{
        grid:{
            borderWidth:0,
            shadow: false,
            backgroundColor: '#FFFFFF'
        },
        highlighter:{
            sizeAdjust: 2,
            tooltipLocation: 'n',
            bringSeriesToFront: true,
            formatString: '<table class="jqplot_highlighter"><tr><td>Month</td><td>: %s</td></tr><tr><td>Cost</td><td>:INR %s Cr</td></tr></table>',
            useAxesFormatters: true
        },
        axesDefaults:{
            pad: 1.5,
            rendererOptions:{
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                labelOptions:{
                    enableFontSupport: true,
                    fontFamily: 'Frutiger, "Frutiger Linotype", Univers, Calibri, "Gill Sans", "Gill Sans MT", "Myriad Pro", Myriad, "DejaVu Sans Condensed", "Liberation Sans", "Nimbus Sans L", Tahoma, Geneva, "Helvetica Neue", Helvetica, Arial, sans-serif',
                    fontSize: '0.9em'
                }
            }
        },
        axes: {
            xaxis:{
                renderer: $.jqplot.DateAxisRenderer,
                tickInterval: '6 months',
                tickOptions: {
                    showMark: false,
                    formatString: '%b-%y',
                    showGridline: false
                }
            },
            yaxis:{
                renderer:$.jqplot.LogAxisRenderer,
                min: 0,
                max: 450,
                tickOptions:{
                    formatString: '%.1f',
                    showGridline: true
                },
                label: 'INR In Crores'
            }
        },
        series: [
        { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
        { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
        { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
        {neighborThreshold: -1}
        ],
        seriesColors: ["#FF9000", "#006CC6", "#00BD39"],
        legend: {
            renderer: $.jqplot.EnhancedLegendRenderer,
            show: true,
            showSwatches: true,
            labels: ['PV Cum', 'LRE Site', 'LRE PMC'],
            rendererOptions: {
                numberRows: 1
            },
            placement: 'outside',
            location: 's',
            marginTop: '40px'
        },
        cursor:{
            show:true,
            zoom:true,
            showTooltip:false
        }
    });
    plot3 = $.jqplot('chart-3', [s7, s8], {
        grid:{
            borderWidth:0,
            shadow: false,
            backgroundColor: '#FFFFFF'
        },
        highlighter:{
            sizeAdjust: 2,
            tooltipLocation: 'n',
            bringSeriesToFront: true,
            formatString: '<table class="jqplot_highlighter"><tr><td>Month</td><td>: %s</td></tr><tr><td>Index</td><td>: %s</td></tr></table>',
            useAxesFormatters: true
        },
        axesDefaults:{
            pad: 1.5,
            rendererOptions:{
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                labelOptions:{
                    enableFontSupport: true,
                    fontFamily: 'Frutiger, "Frutiger Linotype", Univers, Calibri, "Gill Sans", "Gill Sans MT", "Myriad Pro", Myriad, "DejaVu Sans Condensed", "Liberation Sans", "Nimbus Sans L", Tahoma, Geneva, "Helvetica Neue", Helvetica, Arial, sans-serif',
                    fontSize: '0.9em'
                }
            }
        },
        axes: {
            xaxis: {
                renderer: $.jqplot.DateAxisRenderer,
                tickOptions: {
                    formatString: '%b-%y',
                    showGridline: false,
                    showMark: false
                }
            },
            yaxis: {
                min: -0.5,
                max: 1.5,
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                label: 'Performance Index',
                tickOptions: {
                    formatString: '%.2f',
                    showGridline: true
                }
            }
        },
        series: [
        { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} },
        { pointLabels:{show:false}, markerOptions: { lineWidth: 1, style: 'jumpCircle', size: 8, shadow: true, shadowAngle: 45, shadowOffset: 1, shadowDepth: 3} }
        ],
        seriesColors: ["#006CC6","#FF9000"],
        cursor:{
            show:true,
            zoom:true,
            showTooltip:false
        },
        legend: {
            renderer: $.jqplot.EnhancedLegendRenderer,
            show: true,
            showSwatches: true,
            labels: ['Cost Performance', 'Schedule Performance'],
            rendererOptions: {
                numberRows: 1
            },
            placement: 'outside',
            location: 's',
            marginTop: '40px'
        }
    });
});