var App;

jQuery(document).on('turbolinks:load', function() {
  var messages, messages_to_bottom;
  messages = $('#messages');
  if ($('#messages').length > 0) {
    messages_to_bottom = function() {
      messages.scrollTop(messages.prop('scrollHeight'));
    };
    messages_to_bottom();
    App.global_chat = App.cable.subscriptions.create({
      channel: 'GroupsChannel',
      group_id: messages.data('group-id')
    }, {
      received: function(data) {
        var message = data.message;
        var class_message, class_body_message, class_li_message;

        var current_user_id = $('meta[name="current-user"]').data('id');
        if (current_user_id == message.user_id) {
          class_message = 'chat-img1 pull-right';
          class_body_message = 'chat-body2 clearfix';
          class_li_message = 'right clearfix';
        } else {
          class_message = 'chat-img1 pull-left';
          class_body_message = 'chat-body1 clearfix';
          class_li_message = 'left clearfix';
        }

        var message_item = '<ul class="list-unstyled">\
          <li class="' + class_li_message + '">\
            <span class="' + class_message + '">\
              <img src="' + message.user_avatar + '" class="img-circle">\
            </span>\
            <div class="' + class_body_message + '">\
              <p>' + message.content + '</p>\
            </div>\
          </li>\
        </ul>';

        messages.append(message_item);
        return messages_to_bottom();
      },
      send_message: function(message, group_id) {
        return this.perform('send_message', {
          message: message,
          group_id: group_id
        });
      }
    });
    return $('#new_message').submit(function(e) {
      e.preventDefault();
      var textarea;
      textarea = $(this).find('#message_content');
      if ($.trim(textarea.val()).length > 1) {
        App.global_chat.send_message(textarea.val(), messages.data('group-id'));
        textarea.val('');
      }
      return false;
    });
  }
});
