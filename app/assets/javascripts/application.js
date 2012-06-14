// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require_tree .

    $("table .micropost .delete_post a").live('click', function (e) {
        $(this).parent().parent().parent().remove();
    });
    
    

    $(".micropost .image").live('click', function (e) {
        var img=$(this).children("img").attr('alt');
        $(".facepalm_image img").each(function(e,i){
            if($(i).attr('alt')==img){
                $(i).parent().attr('style','align:center;').dialog({
                    height: 'auto',
                    width: 'auto',
                    modal:true
                });
            }
        });
    });
