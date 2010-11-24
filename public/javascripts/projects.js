$(function () {
    $('input[type="text"]').eq(0).focus();
    $('#TblAddProjectForm').hide();
    $('#LnkAddnewproject').click(function() {
        $('#TblAddProjectForm').slideDown(200);
        $('#TblAddnewProject').hide();
        return false;
    });
    $('#LnkCancle').click(function() {
        $('#TblAddProjectForm').slideUp(200);
        $('#TblAddnewProject').delay(400).slideDown(200);
        return false;
    });
});