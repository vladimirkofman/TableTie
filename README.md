# TableTie
Hassle-free **UITableViewDataSource** and **UITableViewDelegate** implementation

### The Goal
To provide a simple, generic way to populate a UITableView with data.  
*Totally inspired by
[Generic Table View Controllers](https://talk.objc.io/episodes/S01E26-generic-table-view-controllers-part-2 "Swift Talk") by [objc.io](https://www.objc.io/)*

## Hello World
Let's say you have a list of Songs and Albums that you want to display in `UITableView`. Your models can be structs, classes, enums, or just Strings. Let's use structs for the example:
```swift
struct Song {
    let title: String
}

struct Album {
    let name: String
    let artist: String
}

class SongCell: UITableViewCell {}
class AlbumCell: UITableViewCell {}
```
You'll need your models to conform to TableTie.Row protocol. There's only one required method that you'll need to implementation: `func configure(cell:)`. In this method you'll configure your cell according to your model. Make sure to use the correct type for the `cell:` parameter: it's generic, and will work for any subclass of `UITableViewCell`.

```swift
extension Song: TableTie.Row {
    func configure(cell: SongCell) {
        cell.textLabel?.text = title
    }
}

extension Album: TableTie.Row {
    func configure(cell: AlbumCell) {
        cell.textLabel?.text = "\(name) by \(artist)"
    }
}
```
In your view controller, you'll need to create an instance of `TableTie.Adapter`, and provide it with the array of your models.
```swift
class MyVC: UITableViewController {  
    let tieAdapter =
      TableTie.Adapter([
          Album(name: "Paranoid", artist:"Black Sabbath"),
          Song(title: "War Pigs"),
          Song(title: "Paranoid"),
          Song(title: "Planet Caravan")])

    override func viewDidLoad() {
        tableView.delegate = tieAdapter
        tableView.dataSource = tieAdapter

        super.viewDidLoad()
    }
}
```
Don't forget to set .delegate and .dataSource for the tableView to the `TableTie.Adapter` instance you've created earlier.    

And that's all!  
*Please read on for more options...*

### Sections
```swift
...
let tieAdapter = Adapter([
        Section("Album", [
            Album(name: "Paranoid", artist:"Black Sabbath"),
        ]),
        Section("Side one", [
            Song(title: "War Pigs"),
            Song(title: "Paranoid"),
            Song(title: "Planet Caravan"),
            Song(title: "Iron Man"),
        ])])
...
```

### Custom reuseIdentifier and Storyboard support
`TableTie` will automagically register your cell for `UITableViewCell` reuse. If you need to use a specific `reuseIdentifier`, or if you've designed your cell in a storyboard, just override the `reuseIdentifier` property of `TableTie.Row`:
```swift
extension Song: TableTie.Row {
    var reuseIdentifier: String { return "reuseMePlease" } // <-- HERE

    func configure(cell: YourStoryboardCell) {
        //Do what you have to do here...
    }
}
```

### Row height
```swift
extension Song: TableTie.Row {
    var reuseIdentifier: String { return "reuseMePlease" }
    var rowHeight: CGFloat { return 100.0 } // <-- HERE

    func configure(cell: YourStoryboardCell) {
        //Do what you have to do here...
    }
}
```

### Row selection
* Option 1: Override `didSelectRow` for the row
```swift
extension Song: TableTie.Row {
...
    func didSelectRow(of tableView: UITableView, at indexPath: IndexPath) {
        // Implement your logic here...
    }
...
}
```
* Option 2: Set `didSelect` closure for `TableTie.Adapter`
```swift
...
tieAdapter.didSelect = { row, tableView, indexPath in
    // Implement your logic here...
}
...
```
