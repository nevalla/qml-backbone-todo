qml-backbone-todo
=================

Example project how to use [backbone.js](http://backbonejs.org/), [underscore.js](underscorejs.org) and [zepto.js](http://zeptojs.com/) with Qt/QML
<img alt="QT/QML Backbone.js Todo" src="https://raw.githubusercontent.com/nevalla/qml-backbone-todo/master/images/ScreenShot.png" width="320" />

This example uses Enginio Data Storage as database. Please see more information [Qt Cloud Services](https://www.qtcloudservices.com)

##Usage
Use Backbone models and collections as usual

```javascript
// app.js
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
```
```javascript
//main.qml
function completeItem(index) {
    var todo = App.todos.at(index)
    todo.save({completed: true}, {success: function(model) {
        todoModel.setProperty(index, "itemProcessing", false);
    }, error: function(){ console.log("error")} } )
    todoModel.set(index, todo);
}
```

Listen events in QML file
```javascript
//main.qml
ListModel {
    id: todoModel
}

Component.onCompleted: {
    App.todos.on("add", function(todo) { todoModel.append(todo) });
    App.getTodos();
}
```
