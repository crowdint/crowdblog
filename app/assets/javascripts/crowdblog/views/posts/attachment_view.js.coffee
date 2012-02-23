$ ->
  PostsApp.AttachmentView = Backbone.View.extend
    template:
      JST["crowdblog/templates/posts/attachment"]

    render: ->
      this.$el.html(this.template(this.options))
      this
