define ['jquery', 'templates'], ($, templates) ->

  class ExampleView

    render: (element) ->
      $(element).append templates.example({name:'Handlebars', css:'pure CSS'})
      $(element).append templates['another-example']({name:'Handlebars'})

  ExampleView