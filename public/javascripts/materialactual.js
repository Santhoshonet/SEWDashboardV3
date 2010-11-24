$(function() {
    var projlist = $('#project-select-dropdown-container');
    projlist.hide().css({
        width:$('.project-select:not(.dropdownbox)').width()
    });
    var flag = false;
    $('.project-name,.project-location').click(function() {
        projlist.slideToggle(200);
        flag = false;
        $('body,.project-name,.project-location').not('.project-name,.project-location').unbind('click');
        $('body,.project-name,.project-location').not('.project-name,.project-location').click(function() {
            if (flag)
                projlist.slideUp(200);
            flag = true;
        });
    });
    $('#TblAddMaterialForm').hide();
    $('#LnkAddnewmaterial').click(function() {
        $('#TblAddMaterialForm').slideDown(200);
        $('#TblAddnewMaterial').hide();
        $('input[type="text"]').eq(0).delay(2000).focus();
        return false;
    });
    $('#LnkCancel').click(function() {
        $('#TblAddMaterialForm').slideUp(200);
        $('#TblAddnewMaterial').delay(400).slideDown(200);
        return false;
    });
});