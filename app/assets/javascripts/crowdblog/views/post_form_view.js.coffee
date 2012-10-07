class Crowdblog.Views.PostFormView extends Backbone.View
  el: 'form'

  initialize: ->
    @$el.find('#post_body').change(@updatePreview)
    @updatePreview()

  events:
    'keyup #post_body' : 'updatePreview'

  updatePreview: (e) ->
    @$el.find('#post-preview').html(markdown.toHTML($('#post_body').val()))
