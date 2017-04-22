# TableTie
Hassle-free and type-safe **UITableViewDataSource** and **UITableViewDelegate** implementation

## Motivation
Bla bla bla
Bring your own model objects and cells

## Solution
Let's say you have a simple model object that you want to display in `UITableView`:
```swift
struct Song {
    let title: String
}
```
Here's how it would look like:
```swift
extension Song: TableTie.Row {
    func configure(cell: UITableViewCell) {
        cell.textLabel?.text = title
    }
}

class MyVC: UITableViewController {  
    let tieAdapter =
      TableTie.Adapter([
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
## Explain about the overriding func

## Custom cells
Sure, just put the right type for the cell in `func configure(cell:)`:
```swift
class YourCustomCell: UITableViewCell {}

extension Song: TableTie.Row {
    func configure(cell: YourCustomCell) {
        //Do what you have to do here...
    }
}
```
`TableTie` will automatically register your cell for `UITableViewCell` reuse. If you want to have specific `reuseIdentifier`, take a look at the next section.

## Cells from a storyboard
No problem, just let it know the `reuseIdentifier`:
```swift
extension Song: TableTie.Row {
    var reuseIdentifier: String { return "reuseMePlease" } // <-- HERE

    func configure(cell: YourStoryboardCell) {
        //Do what you have to do here...
    }
}
```
## Distinct - CHANGEME model types in the same UITableView
```swift
...
let tieAdapter =
  TableTie.Adapter([
      Artist(name: "Black Sabbath"),
      Song(title: "War Pigs"),
      Song(title: "Paranoid"),
      Song(title: "Planet Caravan")])
...
```

## Row height
```swift
extension Song: TableTie.Row {
    var reuseIdentifier: String { return "reuseMePlease" }
    var rowHeight: CGFloat { return 100.0 } // <-- HERE

    func configure(cell: YourStoryboardCell) {
        //Do what you have to do here...
    }
}
```
