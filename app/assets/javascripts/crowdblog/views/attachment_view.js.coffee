class Crowdblog.Views.AttachmentView extends Backbone.View
  tagName: 'div'

  className: 'attachment'

  template:
    _.template("![image alt](<%= attachment.url %>)")

  render: ->
    @$el.html @template($.parseJSON(@options))
    @

