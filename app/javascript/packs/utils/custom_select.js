document.setupCustomSelect = function () {
    // Iterate over each select element
    $('select').each(function () {

        const select = this;
        // select.parent()
        // Cache the number of options
        let $this = $(this),
            numberOfOptions = $(this).children('option').length;

        // Only process the select not has been styled
        if ($this.parent().find(".styled_select").length !== 0) {
            return
        }
        // Hides the select element
        $this.addClass('s-hidden');

        // Wrap the select element in a div
        $this.wrap('<div class="select"></div>');

        // Insert a styled div to sit over the top of the hidden select element
        $this.after('<div class="styled_select"></div>');

        // Cache the styled div
        let $styledSelect = $this.next('div.styled_select');

        let options = $this.children('option')
        let textSelected = ""
        for (let i = 0; i < options.length; i++) {
            if (options[i]["selected"]) {
                textSelected = options[i].text
                break;
            }
        }

        // Show the first select option in the styled div
        // $styledSelect.text($this.children('option').eq(0).text());
        $styledSelect.text(textSelected)

        // Insert an unordered list after the styled div and also cache the list
        let $list = $('<ul />', {
            'class': 'options'
        }).insertAfter($styledSelect);

        // Insert a list item into the unordered list for each select option
        for (let i = 0; i < numberOfOptions; i++) {
            $('<li />', {
                text: $this.children('option').eq(i).text(),
                rel: $this.children('option').eq(i).val()
            }).appendTo($list);
        }

        // Cache the list items
        let $listItems = $list.children('li');

        // Show the unordered list when the styled div is clicked (also hides it if the div is clicked again)
        $styledSelect.click(function (e) {
            e.stopPropagation();
            $('div.styled_select.active').each(function () {
                $(this).removeClass('active').next('ul.options').hide();
            });
            $(this).toggleClass('active').next('ul.options').toggle();
        });

        // Hides the unordered list when a list item is clicked and updates the styled div to show the selected list item
        // Updates the select element to have the value of the equivalent option
        $listItems.click(function (e) {
            // e.stopPropagation();
            $styledSelect.text($(this).text()).removeClass('active');
            $this.val($(this).attr('rel'));
            $list.hide();
            $(select).triggerHandler("change", $this.val($(this).attr('rel')))
            /* alert($this.val()); Uncomment this for demonstration! */
        });

        // Hides the unordered list when clicking outside of it
        $(document).click(function () {
            $styledSelect.removeClass('active');
            $list.hide();
        });

    });
}

document.addEventListener("turbolinks:load", function () {
    document.setupCustomSelect()
});
