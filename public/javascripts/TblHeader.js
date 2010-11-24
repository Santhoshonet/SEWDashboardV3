$(function() {
    $('body').append('<div class="tooltip" id="tooltip"></div>');
    $('#tooltip').hide();
    $('table.data th').mouseenter(function(e) {
        if($(this).attr('tooltip') != "")
        {
            $('#tooltip').html($(this).attr('tooltip'));
            $('#tooltip').css ({
                top: e.pageY - 40,
                left: e.pageX
            }).fadeIn(100);
        }
    }).mouseleave(function() {
        $('#tooltip').hide();                        
    }).mousemove(function(e){
           $('#tooltip').css ({
            top: e.pageY - 40,
            left: e.pageX
        });
    });
});