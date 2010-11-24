(function($) {

    // Provide a cross-browser interface to a few simple drawing primitives
    $.fn.simpledraw = function(width, height, use_existing) {
        if (use_existing && this[0].vcanvas) return this[0].vcanvas;
        if (width==undefined) width=$(this).innerWidth();
        if (height==undefined) height=$(this).innerHeight();
        return new vcanvas_canvas(width, height, this);
    };
    var vcanvas_canvas = function(width, height, target) {
        return this.init(width, height, target);
    };
    var vcanvas_base = function(width, height, target) {
    };
    vcanvas_base.prototype = {
        init : function(width, height, target) {
            this.width = width;
            this.height = height;
            this.target = target;
            if (target[0]) target=target[0];
            target.vcanvas = this;
        },

        drawShape : function(path, lineColor, fillColor, lineWidth) {
            alert('drawShape not implemented');
        },

        drawLine : function(x1, y1, x2, y2, lineColor, lineWidth) {
            return this.drawShape([ [x1,y1], [x2,y2] ], lineColor, lineWidth);
        },

        drawCircle : function(x, y, radius, lineColor, fillColor) {
            alert('drawCircle not implemented');
        },

        drawPieSlice : function(x, y, radius, startAngle, endAngle, lineColor, fillColor) {
            alert('drawPieSlice not implemented');
        },

        drawRect : function(x, y, width, height, lineColor, fillColor) {
            alert('drawRect not implemented');
        },

        getElement : function() {
            return this.canvas;
        },

        _insert : function(el, target) {
            $(target).html(el);
        }
    };
    var vcanvas_canvas = function(width, height, target) {
        return this.init(width, height, target);
    };
    vcanvas_canvas.prototype = $.extend(new vcanvas_base, {
        _super : vcanvas_base.prototype,

        init : function(width, height, target) {
            var canvas = document.createElement('canvas');
            this._super.init(width, height, target);
            if ($.browser.msie) {
                window.G_vmlCanvasManager.init_(document);
            }
            if ($.browser.msie) {
                this.canvas = window.G_vmlCanvasManager.initElement(canvas);
            }
            else{
                this.canvas = canvas;
            }
            /**this.canvas = $(target).find('canvas')[0];**/
            if (target[0]) target=target[0];
            target.vcanvas = this;
            $(this.canvas).css({ display:'inline-block', width:width, height:height, verticalAlign:'top' });
            this._insert(this.canvas, target);
            this.pixel_height = $(this.canvas).height();
            this.pixel_width = $(this.canvas).width();
            this.canvas.width = this.pixel_width;
            this.canvas.height = this.pixel_height;
            $(this.canvas).css({width: this.pixel_width, height: this.pixel_height});
        },

        _getContext : function(lineColor, fillColor, lineWidth) {
            var context = this.canvas.getContext('2d');
            if (lineColor != undefined)
                context.strokeStyle = lineColor;
            context.lineWidth = lineWidth==undefined ? 1 : lineWidth;
            if (fillColor != undefined)
                context.fillStyle = fillColor;
            return context;
        },

        drawShape : function(path, lineColor, fillColor, lineWidth) {
            var context = this._getContext(lineColor, fillColor, lineWidth);
            context.beginPath();
            context.moveTo(path[0][0]+0.5, path[0][1]+0.5);
            for(var i=1, plen=path.length; i<plen; i++) {
                context.lineTo(path[i][0]+0.5, path[i][1]+0.5); // the 0.5 offset gives us crisp pixel-width lines
            }
            if (lineColor != undefined) {
                context.stroke();
            }
            if (fillColor != undefined) {
                context.fill();
            }
        },

        drawCircle : function(x, y, radius, lineColor, fillColor) {
            var context = this._getContext(lineColor, fillColor);
            context.beginPath();
            context.arc(x, y, radius, 0, 2*Math.PI, false);
            if (lineColor != undefined) {
                context.stroke();
            }
            if (fillColor != undefined) {
                context.fill();
            }
        },

        drawPieSlice : function(x, y, radius, startAngle, endAngle, lineColor, fillColor) {
            var context = this._getContext(lineColor, fillColor);
            context.beginPath();
            context.moveTo(x, y);
            context.arc(x, y, radius, startAngle, endAngle, false);
            context.lineTo(x, y);
            context.closePath();
            if (lineColor != undefined) {
                context.stroke();
            }
            if (fillColor) {
                context.fill();
            }
        },

        drawRect : function(x, y, width, height, lineColor, fillColor) {
            return this.drawShape([ [x,y], [x+width, y], [x+width, y+height], [x, y+height], [x, y] ], lineColor, fillColor);
        },
        drawText: function(txt,x,y){
            var ct = this._getContext('#555','#555');
            ct.font = 'normal 12px Frutiger';
            ct.textBaseline = "top";
            ct.textAlign = "center";
            return ct.fillText(txt,x,y);
        }
    });

    $.fn.bulletgraph = function(uservalues, options,tickValues) {
        var options = $.extend({
            type : 'bullet',
            lineColor : '#00f',
            fillColor : '#cdf',
            defaultPixelsPerValue : 3,
            width : 'auto',
            height : 'auto',
            composite : false
        }, options ? options : {});

        return this.each(function() {
            var render = function() {
                var values = (uservalues=='html' || uservalues==undefined) ? $(this).text().split(',') : uservalues;
                var width = options.width=='auto' ? values.length*options.defaultPixelsPerValue : options.width;
                if (options.height == 'auto') {
                    if (!options.composite || !this.vcanvas) {
                        // must be a better way to get the line height
                        var tmp = document.createElement('span');
                        tmp.innerHTML = 'a';
                        $(this).html(tmp);
                        height = $(tmp).innerHeight();
                        $(tmp).remove();
                    }
                } else {
                    height = options.height;
                }

                $.fn.bullet.call(this, values, options, width, height,tickValues);
            };
            // jQuery 1.3.0 completely changed the meaning of :hidden :-/
            if (($(this).html() && $(this).is(':hidden')) || ($.fn.jquery < "1.3.0" && $(this).parents().is(':hidden'))) {
                pending.push([this, render]);
            } else {
                render.call(this);
            }
        });
    };
    $.fn.bullet = function(values, options, width, height,tickValues) {
        values = $.map(values, Number);
        // target, performance, range1, range2, range3
        var options = $.extend({
            targetColor : 'red',
            targetWidth : 2, // width of the target bar in pixels
            performanceColor : 'blue',
            rangeColors : ['#D3DAFE', '#A8B6FF', '#7F94FF' ],
            base : undefined // set this to a number to change the base start number
        }, options);


        width = options.width=='auto' ? '4.0em' : width;

        var target = $(this).simpledraw(width, height, options.composite);
        if (target && values.length>1) {
            var canvas_width = target.pixel_width-Math.ceil(options.targetWidth/2);
            var canvas_height = target.pixel_height;

            var min = Math.min.apply(Math, values);
            var max = Math.max.apply(Math, values);
            if (options.base == undefined) {
                var min = min < 0 ? min : 0;
            } else {
                min = options.base;
            }
            var range = max-min;
            var maxlen = $.map(tickValues.maxValue,Number);
            var barWidth = Math.round((canvas_width-((maxlen.length+1)*4))*((values[2]-min)/range));
            // draw range values
            for(i=2, vlen=values.length; i<vlen; i++) {
                var rangeval = parseInt(values[i]);
                var rangewidth = Math.round(barWidth*((rangeval-min)/range));
                target.drawRect(3, 0, rangewidth-2, canvas_height-31, options.rangeColors[i-2], options.rangeColors[i-2]);
            }

            // draw the performance bar
            var perfval = parseInt(values[1]);
            var perfwidth = Math.round(barWidth*((perfval-min)/range));
            target.drawRect(3, Math.round((canvas_height-30)*0.4), perfwidth-2, Math.round((canvas_height-30)*0.2)-1, options.performanceColor, options.performanceColor);

            // draw the target line
            var targetval = parseInt(values[0]);
            var x = Math.round(barWidth*((targetval-min)/range)-(options.targetWidth/2));
            var targettop = Math.round((canvas_height-30)*0.10);
            var targetheight = (canvas_height-30)-(targettop*2);
            target.drawRect(x, targettop, options.targetWidth-1, targetheight-1, options.targetColor, options.targetColor);
            // draw the x axis and labels
            target.drawLine(3,canvas_height-29,barWidth,canvas_height-29,'#CACACA');
            var tickinterval = (barWidth+1)/Math.round(tickValues.noOfTicks);
            for(i=0, val=Math.round(tickValues.noOfTicks)+1; i<val; i++) {
                if (i==Math.round(tickValues.noOfTicks)){
                    var startfinishx = (i*tickinterval);
                }
                else if (i==0){
                    var startfinishx = i*tickinterval+3;
                }
                else{
                    var startfinishx = i*tickinterval;
                }
                var starty = canvas_height-29;
                var finishy =  canvas_height-24;
                target.drawLine(startfinishx,starty,startfinishx,finishy,'#CACACA');
                /**target.drawText(i*tickinterval,startfinishx,finishy+2);**/
                if (i==0) {
                    target.drawText(tickValues.minValue+tickValues.valueSymbol,startfinishx+5,finishy+2);
                }
                else {
                    textValue = ((tickValues.maxValue-tickValues.minValue)/tickValues.noOfTicks)*i+Math.round(tickValues.minValue);
                    target.drawText(textValue.toString()+tickValues.valueSymbol,startfinishx,finishy+2);
                }
            }
        }  else {
            // Remove the tag contents if sparklines aren't supported
            this.innerHTML = '';
        }
    };
    

})(jQuery);
