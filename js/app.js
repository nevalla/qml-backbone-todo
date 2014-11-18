.pragma library

Qt.include("backbone.js")

$.ajaxSettings["headers"] = {
        "Enginio-Backend-Id": "533d48785a3d8b7d1701291f"
    }

var baseUrl = "https://api.engin.io/v1";
var Todo = Backbone.Model.extend({

});

var TodosCollection = Backbone.Collection.extend({
    model: Todo,
    url: baseUrl+"/objects/todos",

    parse: function(response) {
          return response.results;
    }
});

// API

var todos = new TodosCollection()

function addTodo(text) {
    var model = todos.add({text: text})
    model.save()
}

function getTodos(options) {
    todos.fetch(options);
}

function completeTodo(options) {
    todos.fetch(options);
}



