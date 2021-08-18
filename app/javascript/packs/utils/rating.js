document.addEventListener("turbolinks:load", function () {
    $('.rating-input input').click(function () {
        $(".rating-input span").removeClass('checked');
        $(this).parent().addClass('checked');
    });

    $.fn.stars = function () {
        return $(this).each(function () {
            const starWidth = $(this).width() / 5;
            const width = Math.max(0, (Math.min(5, parseFloat($(this).html())))) * starWidth;
            $(this).html(`<span style=\"width: ${width}px;position: absolute;top: 0;background: #fff;\"></span><span style=\"width: ${width}px;z-index: 100;position: absolute;top: 0;\"></span>`)
        });
    }

    $(document).ready(function () {
        $('span.rating-stars').stars();
    });
})
