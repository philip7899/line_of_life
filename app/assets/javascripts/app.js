// Main Application Script
window.ImageLoader = {
  Models: {},
  Collections: {},
  Views: {},

  start: function(data) {
    var images = new ImageLoader.Collections.Images(data.images),
        router = new ImageLoader.Router();

    router.on('route:home', function() {
      router.navigate('images', {
        trigger: true,
        replace: true
      });
    });

    router.on('route:showImages', function() {
      var imagesView = new ImageLoader.Views.Images({
        collection: images
      });

      $('.main-container').html(imagesView.render().$el);
    });

    router.on('route:newImage', function() {
      var newQuestionForm = new ImageLoader.Views.QuestionForm({
        model: new ImageLoader.Models.User()
      });

      newQuestionForm.on('form:submitted', function(attrs) {
        attrs.id = images.isEmpty() ? 1 : (_.max(images.pluck('id')) + 1);
        images.add(attrs);
        router.navigate('images', true);
      });

      $('.main-container').html(newQuestionForm.render().$el);
    });

    Backbone.history.start();
  }
};
