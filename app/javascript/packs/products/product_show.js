document.addEventListener("turbolinks:load", function () {
    document.setupComment()
})

document.setupComment = function () {
    setupToggleReplies()
    setupBtnsReply()
}

function setupToggleReplies() {
    const showReplies = document.getElementsByClassName("btn-show-replies")
    for (let i = 0; i < showReplies.length; i++) {
        const buttonShow = showReplies[i]
        buttonShow.addEventListener('click', function () {
            const id = buttonShow.attributes['data-id'].value
            const containerShowReplies = document.getElementById(`reply-container-${id}`)
            buttonShow.style.display = 'none'
            if (containerShowReplies != null) {
                containerShowReplies.style.display = 'inherit'
                const hideBtn = document.getElementById(`btn-hide-replies-${id}`)
                if (hideBtn != null) {
                    hideBtn.style.display = 'inherit'
                }
                return
            }

            Rails.ajax({
                url: "/products/show_replies",
                type: "post",
                beforeSend(xhr, options) {
                    xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                    // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                    // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                    options.data = JSON.stringify({'comment_id': id})
                    return true
                },
            })
        })
    }
}

function setupBtnsReply() {
    const btnsAddReply = document.getElementsByClassName("btn-add-reply")
    for (let i = 0; i < btnsAddReply.length; i++) {
        const btnAddReply = btnsAddReply[i]
        btnAddReply.addEventListener('click', function () {
            const id = btnAddReply.attributes['data-id'].value
            Rails.ajax({
                url: "/products/add_reply_form",
                type: "post",
                beforeSend(xhr, options) {
                    xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
                    // Workaround: add options.data late to avoid Content-Type header to already being set in stone
                    // https://github.com/rails/rails/blob/master/actionview/app/assets/javascripts/rails-ujs/utils/ajax.coffee#L53
                    options.data = JSON.stringify({'comment_id': id})
                    return true
                },
            })
        })
    }
}