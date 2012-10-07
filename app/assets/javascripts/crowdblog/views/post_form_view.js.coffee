class Crowdblog.Views.PostFormView extends Backbone.View
  el: 'form'

  initialize: ->
    @$el.find('#post_body').change(@updatePreview)
    @updatePreview()
    $('#uploader').html5Uploader
      postUrl: 'assets'
      name: 'attachment'
      onSuccess: @onUploadSuccess

  events:
    'keyup #post_body' : 'updatePreview'

  updatePreview: (e) ->
    @$el.find('#post-preview .inner').html(markdown.toHTML($('#post_body').val()))

  onUploadSuccess: (request, file, object) ->
    attachmentView = new Crowdblog.Views.AttachmentView(object)
    $('#assets').append attachmentView.render().el

