$(function() {
    //$('.filter-container').hide();
    $('.menu-button a').unbind('click');
    $('.menu-button a').click(function() {
        $('.filter-container').slideToggle(300);              
    });
    $('#FilterSubmitButton').click(function() {
        $('form').submit();
    });
});